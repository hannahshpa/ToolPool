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
    public let returnAccepted: Bool?
    public let status: BorrowStatus
    
    public func getTool(context: Context, arguments: NoArguments) -> EventLoopFuture<Tool>{
        DBTool.getById(id: self.toolId, db: context.getDB()).map{tool in tool!}
    }
    public func getUser(context: Context, arguments: NoArguments) -> EventLoopFuture<User>{
        DBUser.getById(id: self.userId, db: context.getDB()).map{ user in user!}
    }
}
