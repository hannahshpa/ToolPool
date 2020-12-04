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

public struct ToolRating: Codable{
    public let toolId: Int
    public let userId: Int
    public let rating: Int
    public let review: String?
    public func getTool(ctx: Context, arguments: NoArguments) -> EventLoopFuture<Tool>{
        DBTool.getById(id: self.toolId, db: ctx.db).map{tool in tool!}
    }
    public func getUser(ctx: Context, arguments: NoArguments) -> EventLoopFuture<User>{
        DBUser.getById(id: self.userId, db: ctx.db).map{user in user!}
    }
}
