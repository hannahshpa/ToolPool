//
//  Context.swift
//  
//
//  Created by Robert Geil on 10/24/20.
//

import Foundation
import PostgresKit
import NIO
struct DBUser: Codable {
    let name: String
    let user_id: Int64
}
public final class Context {
    let conn: DatabaseConnection
    let authedUser: User?
    init(conn: DatabaseConnection, authedUser: User?){
        self.conn = conn
        self.authedUser = authedUser
    }
    
    public func getUser(id: Int) -> EventLoopFuture<User?> {
        return conn.getDB().simpleQuery("SELECT * FROM users").map{ result in
            let user = try? result.first?.sql().decode(model: DBUser.self);
            if let user = user{
                return nil;//User(id: Int(user.user_id), name: user.name);
            }else{
                return nil;
            }
        }
    }
}
