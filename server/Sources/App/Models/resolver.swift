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
private struct DBUser: Codable{
    public let user_id: Int
    public let name: String
    public let phone_number: String
    public let email: String
    public func toUser() -> User{
        User(id: user_id, name: name, phoneNumber: phone_number, email: email)
    }
}
private struct DBUserRating: Codable{
    public let reviewer: Int
    public let reviewee: Int
    public let rating: Int
    public let review: String?
    public func toUserRating() -> UserRating{
        UserRating(reviewerId: reviewer, revieweeId: reviewee, rating: rating, review: review)
    }
}
private struct DBTool: Codable{
    public let tool_id: Int
    public let name: String
    public let description: String
    public let condition: ToolCondition
    public let lat: Double
    public let lon: Double
    public let owner: Int
    public func toTool() -> Tool{
        Tool(id: tool_id, description: description, name: name, condition: condition, location: .init(lat: lat, lon: lon), ownerId: owner)
    }
}
private struct DBToolImages: Codable{
    public let tool: Int
    public let image_uri: String
}
private struct DBToolTags: Codable{
    public let tool: Int
    public let tag: String
}
private struct DBToolSchedule: Codable{
    public let tool: Int
    public let slot_start: Date
    public let slot_end: Date
    public func toTimeSlot()->TimeSlot{
        TimeSlot(start: slot_start, end: slot_end)
    }
}
private struct DBToolRating: Codable{
    public let tool: Int
    public let user: Int
    public let rating: Int
    public let review: String?
    public func toToolRating() -> ToolRating{
        ToolRating(toolId: tool, userId: user, rating: rating, review: review)
    }
}
private struct DBBorrow: Codable{
    public let borrow_id: Int
    public let tool: Int
    public let user: Int
    public let cost: Float
    public let loan_start: Date
    public let loan_end: Date
    public let time_returned: Date?
    public func toBorrow() -> Borrow{
        Borrow(id: borrow_id, toolId: tool, userId: user, cost: Double(cost), loanPeriod: .init(start: loan_start, end: loan_end), timeReturned: time_returned)
    }
}
extension User{
    public func getOwnedTools(context: Context, arguments: NoArguments) -> EventLoopFuture<[Tool]>{
        context.getDB().query("SELECT *, location[0] as lat, location[1] as lon FROM tools WHERE owner = $1",
                              [PostgresData(int: self.id)]).map{result in
            result.rows.map{ row in
                try! row.sql().decode(model: DBTool.self).toTool()
            }
        }
    }
    public func getBorrowHistory(context: Context, arguments: NoArguments) -> EventLoopFuture<[Borrow]>{
        context.getDB().query("SELECT *, LOWER(loan_period) AS loan_start, UPPER(loan_period) as loan_end FROM borrow WHERE \"user\" = $1",
                              [PostgresData(int: self.id)]).map{result in
            result.rows.map{row in
                try! row.sql().decode(model: DBBorrow.self).toBorrow()
            }
        }
    }
    public func getRatings(context: Context, arguments: NoArguments) -> EventLoopFuture<[UserRating]>{
        context.getDB().query("SELECT * FROM user_ratings WHERE reviewee = $1", [PostgresData(int: self.id)]).map{result in
            result.rows.map{row in
                try! row.sql().decode(model: DBUserRating.self).toUserRating()
            }
        }
    }
}
extension Tool{
    public func getOwner(context: Context, arguments: NoArguments) -> EventLoopFuture<User>{
        context.getDB().query("SELECT * FROM users WHERE user_id = $1", [PostgresData(int: self.ownerId)]).map{ result in
            try! result.first!.sql().decode(model: DBUser.self).toUser()
        }
    }
    public func getImages(context: Context, arguments: NoArguments) -> EventLoopFuture<[String]>{
        context.getDB().query("SELECT * FROM tool_images WHERE tool = $1", [PostgresData(int: self.id)]).map{ result in
            result.rows.map{row in
                try! row.sql().decode(model: DBToolImages.self).image_uri
            }
        }
    }
    public func getTags(context: Context, arguments: NoArguments) -> EventLoopFuture<[String]>{
        context.getDB().query("SELECT * FROM tool_tags WHERE tool = $1", [PostgresData(int: self.id)]).map{ result in
            result.rows.map{row in
                try! row.sql().decode(model: DBToolTags.self).tag
            }
        }
    }
    public func getBorrowHistory(context: Context, arguments: NoArguments) -> EventLoopFuture<[Borrow]>{
        context.getDB().query("SELECT *, LOWER(loan_period) AS loan_start, UPPER(loan_period) as loan_end FROM borrow WHERE tool = $1",
                              [PostgresData(int: self.id)]).map{ result in
            result.rows.map{row in
                try! row.sql().decode(model: DBBorrow.self).toBorrow()
            }
        }
    }
    public func getRatings(context: Context, arguments: NoArguments) -> EventLoopFuture<[ToolRating]>{
        context.getDB().query("SELECT * FROM tool_ratings WHERE tool = $1", [PostgresData(int: self.id)]).map{result in
            result.rows.map{row in
                try! row.sql().decode(model: DBToolRating.self).toToolRating()
            }
        }
    }
    public func getSchedule(context: Context, arguments: NoArguments) -> EventLoopFuture<[TimeSlot]>{
        context.getDB().query("SELECT *, LOWER(period) as slot_start, UPPER(period) as slot_end FROM tool_schedule WHERE tool = $1", [PostgresData(int: self.id)]).map{result in
            result.rows.map{ row in
                try! row.sql().decode(model: DBToolSchedule.self).toTimeSlot()
            }
        }
    }
}
extension Borrow{
    public func getTool(context: Context, arguments: NoArguments) -> EventLoopFuture<Tool>{
        context.getDB().query("SELECT *, location[0] as lat, location[1] as lon FROM tools WHERE tool_id = $1", [PostgresData(int: self.toolId)]).map{ result in
            try! result.first!.sql().decode(model: DBTool.self).toTool()
        }
    }
    public func getUser(context: Context, arguments: NoArguments) -> EventLoopFuture<User>{
        context.getDB().query("SELECT * FROM users WHERE user_id = $1", [PostgresData(int: self.userId)]).map{ result in
            try! result.first!.sql().decode(model: DBUser.self).toUser()
        }
    }
}
extension ToolRating{
    public func getTool(context: Context, arguments: NoArguments) -> EventLoopFuture<Tool>{
        context.getDB().query("SELECT *, location[0] as lat, location[1] as lon FROM tools WHERE tool_id = $1",
                              [PostgresData(int: self.toolId)]).map{ result in
            try! result.first!.sql().decode(model: DBTool.self).toTool()
        }
    }
    public func getUser(context: Context, arguments: NoArguments) -> EventLoopFuture<User>{
        context.getDB().query("SELECT * FROM users WHERE user_id = $1", [PostgresData(int: self.userId)]).map{ result in
            try! result.first!.sql().decode(model: DBUser.self).toUser()
        }
    }
}
extension UserRating{
    public func getReviewer(context: Context, arguments: NoArguments) -> EventLoopFuture<User>{
        context.getDB().query("SELECT * FROM users WHERE user_id = $1", [PostgresData(int: self.reviewerId)]).map{ result in
            try! result.first!.sql().decode(model: DBUser.self).toUser()
        }
    }
    public func getReviewee(context: Context, arguments: NoArguments) -> EventLoopFuture<User>{
        context.getDB().query("SELECT * FROM users WHERE user_id = $1", [PostgresData(int: self.revieweeId)]).map{ result in
            try! result.first!.sql().decode(model: DBUser.self).toUser()
        }
    }
}
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
