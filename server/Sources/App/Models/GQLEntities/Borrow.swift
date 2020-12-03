//
//  User.swift
//  
//
//  Created by Robert Geil on 11/16/20.
//

import Foundation
import NIO
import PostgresKit
import Graphiti
public struct Borrow: Codable{
    public let id: Int
    public let toolId: Int
    public let userId: Int
    public let cost: Double
    public let loanPeriod: TimeSlot
    public let timeReturned: Date?
    public var timeReturnedDouble: Double? {
        get{return timeReturned?.timeIntervalSinceReferenceDate}
    }
    public let status: BorrowStatus
    
    public func getTool(ctx: Context, arguments: NoArguments) -> EventLoopFuture<Tool>{
        DBTool.getById(id: self.toolId, db: ctx.db).map{tool in tool!}
    }
    public func getUser(ctx: Context, arguments: NoArguments) -> EventLoopFuture<User>{
        DBUser.getById(id: self.userId, db: ctx.db).map{ user in user!}
    }
}
