//
//  resolver.swift
//  
//
//  Created by Robert Geil on 10/24/20.
//

import Foundation
import Graphiti
public struct Resolver{
    public func `self`(context: Context, arguments: NoArguments) -> User?{
        return context.getUser(id: 5)
    }
    public struct ToolArgs: Codable{
        public let id: Int
    }
    public func tool(context: Context, arguments: ToolArgs) -> Tool?{
        return context.getTool(id: arguments.id)
    }
}
