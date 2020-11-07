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
public struct Resolver{
    let conn: DatabaseConnection;

    public func `self`(context: Context, arguments: NoArguments) -> EventLoopFuture<User?>{
        context.getUser(id: 5)
    }
    public struct ToolArgs: Codable{
        public let id: Int
    }
    private struct ToolResult: Codable{
        public let tool_id: Int
        public let name: String
        public let description: String
        public let condition: ToolCondition
    }
    public func tool(context: Context, arguments: ToolArgs) -> EventLoopFuture<Tool?>{
        conn.getDB().query("SELECT * FROM tools WHERE tool_id = $1", [PostgresData(int64: Int64(arguments.id))]).map{ result in
            let tool = try? result.first?.sql().decode(model: ToolResult.self);
            if let tool = tool{
                return Tool(id: tool.tool_id, description: tool.description, name: tool.name, condition: tool.condition, owner: nil)
            }else{
                return nil;
            }
        }
    }
}
