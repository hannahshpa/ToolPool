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
    
    public struct ToolArgs: Codable{
        public let id: Int
    }
    public func tool(context: Context, arguments: ToolArgs) -> EventLoopFuture<Tool?>{
        let db = conn.getDB()
        return db.query("SELECT *, location[0] as lat, location[1] as lon FROM tools WHERE tool_id = $1;",
                        [PostgresData(int64: Int64(arguments.id))]).map{ result -> Tool? in
            if let dbTool = try? result.first?.sql().decode(model: DBTool.self){
                return dbTool.toTool()
            }else{
                return nil
            }
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
    public func addTool(context: Context, arguments: NewToolArgs) -> EventLoopFuture<Bool>{
        let tool = arguments.tool
        if let user = context.getUser(){
            return conn.getDB().query("INSERT INTO tools (name, description, owner) VALUES ($1, $2, $3);",
                                      [PostgresData(string: tool.name),
                                       PostgresData(string: tool.description),
                                       PostgresData(int64: Int64(user.id))]
            ).map{_ in true }
        }else{
            return conn.getDB().eventLoop.makeFailedFuture(Abort(.forbidden))
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
    public func borrowTool(context: Context, arguments: BorrowArgs) -> EventLoopFuture<Bool>{
        return context.getDB().eventLoop.makeSucceededFuture(true)
    }
}
