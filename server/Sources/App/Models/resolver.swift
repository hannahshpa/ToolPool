//
//  resolver.swift
//  
//
//  Created by Robert Geil on 10/24/20.
//

import Foundation
import Graphiti
import NIO

public struct Resolver{
    public func `self`(context: Context, arguments: NoArguments) -> EventLoopFuture<User?>{
        context.getUser(id: 5)
    }
    public struct ToolArgs: Codable{
        public let id: Int
    }
    public func tool(context: Context, arguments: ToolArgs) -> Tool?{
        context.getTool(id: arguments.id)
    }
}
