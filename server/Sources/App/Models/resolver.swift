//
//  resolver.swift
//  
//
//  Created by Robert Geil on 10/24/20.
//

import Foundation
import Graphiti
import NIO
import PostgresKit
import Vapor

public struct Resolver{
    let conn: DatabaseConnection;
    
    public func `self`(context: Context, arguments: NoArguments) -> User?{
        context.getUser()
    }
    
    public struct IdArg: Codable{
        public let id: Int
    }
    public func tool(context: Context, arguments: IdArg) -> EventLoopFuture<Tool?>{
        DBTool.getById(id: arguments.id, db: conn.getDB())
    }
    
    public func borrow(context: Context, arguments: IdArg) -> EventLoopFuture<Borrow?>{
        conn.getDB().query("SELECT *, LOWER(loan_period) AS loan_start, UPPER(loan_period) as loan_end FROM borrow WHERE borrow_id = $1", [arguments.id.postgresData!]).map{result in
            try? result.first?.sql().decode(model: DBBorrow.self).toBorrow()
        }
    }
    public struct NearbyArgs: Codable{
        public let center: GeoLocationInput
        public let radius: Double
    }
    public func nearby(context: Context, arguments: NearbyArgs) -> EventLoopFuture<[Tool]>{
        // This is pretty insecure, but unfortunately there is no support for polygons in Postgrekit
        // Graphql *should* prevent anything other than the correct data types from coming in, but still...
        conn.getDB().query(
            "SELECT * FROM tools WHERE circle '<(\(arguments.center.lat),\(arguments.center.lon)) \(arguments.radius)>' @> location;").map{result -> [Tool] in
                return result.rows.map{row -> Tool in
                    try! row.sql().decode(model: DBTool.self).toTool()
                }
            }
    }
    
    // Mutations
    public struct NewToolArgs: Codable{
        public let tool: NewToolInput
    }
    public func addTool(context: Context, arguments: NewToolArgs) -> EventLoopFuture<Tool>{
        let tool = arguments.tool
        guard let user = context.getUser() else{
            return conn.getDB().eventLoop.makeFailedFuture(Abort(.forbidden))
        }
        if user.id != tool.ownerId{
            return self.conn.getDB().eventLoop.makeFailedFuture(Abort(.badRequest))
        }
        if tool.tags.count == 0 || tool.images.count == 0{
            return self.conn.getDB().eventLoop.makeFailedFuture(Abort(.badRequest,
                                                                      headers: .init(),
                                                                      reason: "At least 1 tag and 1 image must be attached!",
                                                                      suggestedFixes: []))
        }
        
        let query = """
            WITH id AS (INSERT INTO tools (name, description, condition, hourly_cost, location, owner) VALUES
                       ($1, $2, $3::toolcondition, $4, POINT($5, $6), $7) RETURNING tool_id),
                _ AS (INSERT INTO tool_tags (tool, tag) VALUES
                    \(tool.tags.enumerated().map{(i, _) in "((SELECT tool_id FROM id), $\(i + 8))"}.joined(separator: ",")))
            INSERT INTO tool_images (tool, image_uri) VALUES
                    \(tool.images.enumerated().map{(i, _) in "((SELECT tool_id FROM id), $\(i + 8 + tool.tags.count))"}.joined(separator: ",")) RETURNING tool;
        """
        return conn.getDB().query(query, [ tool.name.postgresData!,
                                           tool.description.postgresData!,
                                           tool.condition.rawValue.postgresData!,
                                           tool.hourlyCost.postgresData!,
                                           tool.location.lat.postgresData!, tool.location.lon.postgresData!,
                                           tool.ownerId.postgresData!]
                                    + tool.tags.map{tag in tag.postgresData!}
                                    + tool.images.map{img in img.postgresData!}).map{result in
                                        Tool(id: result.first!.column("tool")!.int!, description: tool.description, name: tool.name, condition: tool.condition, location: .init(lat: tool.location.lon, lon: tool.location.lon), ownerId: tool.ownerId, hourlyCost: tool.hourlyCost)
                                    }
    }
    
    public func deleteTool(context: Context, arguments: IdArg) -> EventLoopFuture<Bool>{
        guard let user = context.getUser() else{
            return conn.getDB().eventLoop.makeFailedFuture(Abort(.forbidden))
        }
        return conn.getDB().query("DELETE FROM tools WHERE tool_id = $1 AND owner = $2 RETURNING tool_id",
                                  [arguments.id.postgresData!, user.id.postgresData!]).map{ results in
                                    results.count == 1
                                  }
    }
    
    public func updateTool(context: Context, arguments: NewToolArgs) -> EventLoopFuture<Bool>{
        return context.getDB().eventLoop.makeSucceededFuture(true)
    }
    
    public struct BorrowArgs: Codable{
        public let toolId: Int
        public let userId: Int
        public let startTime: Date
        public let endTime: Date
    }
    
    public func requestBorrow(context: Context, arguments: BorrowArgs) -> EventLoopFuture<Int>{
        guard let user = context.getUser() else{
            return context.getDB().eventLoop.makeFailedFuture(Abort(.forbidden))
        }
        if(user.id != arguments.userId){
            return context.getDB().eventLoop.makeFailedFuture(Abort(.badRequest))
        }
        return DBTool.getById(id: arguments.toolId, db: conn.getDB()).map{result in
            result!.hourlyCost * arguments.endTime.timeIntervalSince(arguments.startTime) / 3600
        }.flatMap{cost in
            context.getDB().query("INSERT INTO borrow (tool, \"user\", cost, loan_period) VALUES ($1, $2, $3, tstzrange($4, $5)) RETURNING borrow_id",
                                  [arguments.toolId.postgresData!, arguments.userId.postgresData!, cost.postgresData!, arguments.startTime.postgresData!, arguments.endTime.postgresData!])
        }.map{result in
            result.first!.column("borrow_id")!.int!
        }
    }
    
    public func approveBorrow(context: Context, arguments: IdArg) -> EventLoopFuture<Bool>{
        guard let user = context.getUser() else {
            return conn.getDB().eventLoop.makeFailedFuture(Abort(.forbidden))
        }
        return conn.getDB().query("""
            WITH t as (SELECT 1 FROM borrow JOIN tools ON tool_id = tool WHERE borrow_id = $1 AND owner = $2)
            UPDATE borrow SET status = 'accepted' FROM t WHERE borrow.borrow_id = $1;
            """, [arguments.id.postgresData!, user.id.postgresData!]).map{result in
                result.count == 1
            }
    }
    
    public func denyBorrow(context: Context, arguments: IdArg) -> EventLoopFuture<Bool>{
        guard let user = context.getUser() else{
            return conn.getDB().eventLoop.makeFailedFuture(Abort(.forbidden))
        }
        return conn.getDB().query("""
            WITH t as (SELECT 1 FROM borrow JOIN tools ON tool_id = tool WHERE borrow_id = $1 AND owner = $2)
            UPDATE borrow SET status = 'rejected' FROM t WHERE borrow.borrow_id = $1;
            """, [arguments.id.postgresData!, user.id.postgresData!]).map{result in
                result.count == 1
            }
    }
    
    public struct RatingArgs: Codable{
        public let reviewerId: Int
        public let revieweeId: Int
        public let review: String?
        public let rating: Int
    }
    public struct DeleteRatingArgs: Codable{
        public let reviewerId: Int
        public let revieweeId: Int
    }
    public func createUserRating(context: Context, arguments: RatingArgs) -> EventLoopFuture<UserRating>{
        conn.getDB().eventLoop.makeFailedFuture(Abort(.notImplemented))
    }
    public func deleteUserRating(context: Context, arguments: DeleteRatingArgs) -> EventLoopFuture<Bool>{
        conn.getDB().eventLoop.makeFailedFuture(Abort(.notImplemented))
    }
    public func createToolRating(context: Context, arguments: RatingArgs) -> EventLoopFuture<ToolRating>{
        conn.getDB().eventLoop.makeFailedFuture(Abort(.notImplemented))
    }
    public func deleteToolRating(context: Context, arguments: DeleteRatingArgs) -> EventLoopFuture<Bool>{
        conn.getDB().eventLoop.makeFailedFuture(Abort(.notImplemented))
    }
}
