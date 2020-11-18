//
//  dbmodels.swift
//  
//
//  Created by Robert Geil on 11/16/20.
//

import Foundation
import PostgresKit
public struct DBUser: Codable{
    public let user_id: Int
    public let name: String
    public let phone_number: String
    public let email: String
    public func toUser() -> User{
        User(id: user_id, name: name, phoneNumber: phone_number, email: email)
    }
    public static func getById(id: Int, db: PostgresDatabase) -> EventLoopFuture<User?>{
        db.query("SELECT * FROM users WHERE user_id = $1", [PostgresData(int: id)]).map{ result in
            try? result.first?.sql().decode(model: DBUser.self).toUser()
        }
    }
}
public struct DBUserRating: Codable{
    public let reviewer: Int
    public let reviewee: Int
    public let rating: Int
    public let review: String?
    public func toUserRating() -> UserRating{
        UserRating(reviewerId: reviewer, revieweeId: reviewee, rating: rating, review: review)
    }
}
public struct DBTool: Codable{
    public let tool_id: Int
    public let name: String
    public let description: String
    public let condition: ToolCondition
    public let hourly_cost: Double
    public let lat: Double
    public let lon: Double
    public let owner: Int
    public func toTool() -> Tool{
        Tool(id: tool_id, description: description, name: name, condition: condition, location: .init(lat: lat, lon: lon), ownerId: owner, hourlyCost: hourly_cost)
    }
    public static func getById(id: Int, db: PostgresDatabase) -> EventLoopFuture<Tool?>{
        db.query("SELECT *, location[0] as lat, location[1] as lon FROM tools WHERE tool_id = $1", [PostgresData(int: id)]).map{ result in
            try? result.first?.sql().decode(model: DBTool.self).toTool()
        }
    }
}
public struct DBToolImages: Codable{
    public let tool: Int
    public let image_uri: String
}
public struct DBToolTags: Codable{
    public let tool: Int
    public let tag: String
}
public struct DBToolSchedule: Codable{
    public let tool: Int
    public let slot_start: Date
    public let slot_end: Date
    public func toTimeSlot()->TimeSlot{
        TimeSlot(start: slot_start, end: slot_end)
    }
}
public struct DBToolRating: Codable{
    public let tool: Int
    public let user: Int
    public let rating: Int
    public let review: String?
    public func toToolRating() -> ToolRating{
        ToolRating(toolId: tool, userId: user, rating: rating, review: review)
    }
}
public struct DBBorrow: Codable{
    public let borrow_id: Int
    public let tool: Int
    public let user: Int
    public let cost: Float
    public let loan_start: Date
    public let loan_end: Date
    public let time_returned: Date?
    public let status: BorrowStatus
    public func toBorrow() -> Borrow{
        Borrow(id: borrow_id, toolId: tool, userId: user, cost: Double(cost), loanPeriod: .init(start: loan_start, end: loan_end), timeReturned: time_returned, status: status)
    }
}
