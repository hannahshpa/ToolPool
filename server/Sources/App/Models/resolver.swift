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
    private struct ToolResult: Codable{
        public let tool_id: Int
        public let name: String
        public let description: String
        public let condition: ToolCondition
        public let owner_id: Int
        public let owner_name: String
        public let owner_phone_number: String
        public let owner_email: String
        public let lat: Double
        public let lon: Double
        public let images: [String]
        public let tags: [String]
    }
    
    private struct BorrowResult: Codable{
        public let borrow_id: Int
        public let cost: Float
        public let loan_start: Date
        public let loan_end: Date
        public let time_returned: Date?
        public let user_id: Int
        public let user_name: String
        public let user_email: String
        public let user_phone_number: String
    }
    public func tool(context: Context, arguments: ToolArgs) -> EventLoopFuture<Tool?>{
        let db = conn.getDB()
        return db.query("SELECT * FROM fulltool_v WHERE tool_id = $1;", [PostgresData(int64: Int64(arguments.id))]).map{ result -> ToolResult? in
            return try! result.first?.sql().decode(model: ToolResult.self)
        }.flatMap{ tool in
            // Saturate with borrow values
            if let tool = tool{
                return db.query("""
                    SELECT borrow_id, cost, u.user_id as user_id, u.email as user_email, u.name as user_name, u.phone_number as user_phone_number, LOWER(loan_period) AS loan_start, UPPER(loan_period) as loan_end, time_returned
                    FROM borrow
                    JOIN users u ON u.user_id = "user"
                    WHERE tool = $1;
                    """, [PostgresData(int64: Int64(arguments.id))]).map{ result in
                        var t = Tool(id: tool.tool_id,
                                     description: tool.description,
                                     name: tool.name,
                                     condition: tool.condition,
                                     location: .init(lat: tool.lat, lon: tool.lon),
                                     owner: User(id: tool.owner_id,
                                                 name: tool.owner_name,
                                                 phoneNumber: tool.owner_phone_number,
                                                 email: tool.owner_email,
                                                 ownedTools: nil,
                                                 borrowHistory: nil),
                                     borrowHistory: nil,
                                     images: tool.images,
                                     tags: tool.tags)
                        t.borrowHistory = result.rows.map{ row -> Borrow in
                            let borrowResult = try! row.sql().decode(model: BorrowResult.self)
                            return Borrow(id: borrowResult.borrow_id,
                                          tool: t,
                                          user: User(id: borrowResult.user_id,
                                                     name: borrowResult.user_name,
                                                     phoneNumber: borrowResult.user_phone_number,
                                                     email: borrowResult.user_email,
                                                     ownedTools: nil,
                                                     borrowHistory: nil),
                                          cost: Double(borrowResult.cost),
                                          loanPeriod:.init(start: Date(), end: Date()),
                                          timeReturned: nil)
                        }
                        return t
                    }
            }else{
                return db.eventLoop.makeSucceededFuture(nil)
            }
        }
        
    }
    private struct BorrowToolUser: Codable{
        public let borrow_id: Int
        public let cost: Float
        public let loan_start: Date
        public let loan_end: Date
        public let time_returned: Date?
        public let user_id: Int
        public let user_name: String
        public let user_email: String
        public let user_phone_number: String
        public let tool_id: Int
        public let tool_name: String
        public let tool_description: String
        public let tool_condition: ToolCondition
        public let tool_lat: Double
        public let tool_lon: Double
        public let tool_images: [String]
        public let tool_tags: [String]
    }
    public func borrow(context: Context, arguments: ToolArgs) -> EventLoopFuture<Borrow?>{
        conn.getDB().query("SELECT * from fullborrow_v WHERE borrow_id = $1;",
                           [PostgresData(int64: Int64(arguments.id))]).map{ result -> Borrow? in
                            if let borrow = try? result.first?.sql().decode(model: BorrowToolUser.self){
                                return Borrow(id: borrow.borrow_id,
                                              tool: .init(id: borrow.tool_id,
                                                          description: borrow.tool_description,
                                                          name: borrow.tool_name,
                                                          condition: borrow.tool_condition,
                                                          location: .init(lat: borrow.tool_lat, lon: borrow.tool_lon),
                                                          owner: nil,
                                                          borrowHistory: nil,
                                                          images: borrow.tool_images,
                                                          tags: borrow.tool_tags),
                                              user: .init(id: borrow.user_id,
                                                          name: borrow.user_name,
                                                          phoneNumber: borrow.user_phone_number,
                                                          email: borrow.user_email,
                                                          ownedTools: nil,
                                                          borrowHistory: nil),
                                              cost: Double(borrow.cost),
                                              loanPeriod: .init(start: borrow.loan_start, end: borrow.loan_end),
                                              timeReturned: borrow.time_returned)
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
            "SELECT * FROM fulltool_v WHERE circle '<(\(arguments.center.lat),\(arguments.center.lon)) \(arguments.radius)>' @> location;").map{result -> [Tool] in
                return result.rows.map{row -> Tool in
                    let tr = try! row.sql().decode(model: ToolResult.self)
                    return Tool(id: tr.tool_id, description: tr.description, name: tr.name, condition: tr.condition, location: .init(lat: tr.lat, lon: tr.lon), owner: .init(id: tr.owner_id, name: tr.owner_name, phoneNumber: tr.owner_phone_number, email: tr.owner_email, ownedTools: nil, borrowHistory: nil), borrowHistory: nil, images: tr.images, tags: tr.tags)
                }
             }
    }
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
}
