//
//  Context.swift
//  
//
//  Created by Robert Geil on 10/24/20.
//

import Foundation
import PostgresKit

public final class Context {
    private var authedUser: User?
    private let conn: DatabaseConnection
    init(user: User?, conn: DatabaseConnection) {
        self.conn = conn
        self.authedUser = user
    }
    
    public func getUser() -> User? {
        self.authedUser
    }
    public func getDB() -> PostgresDatabase{
        self.conn.getDB()
    }
}

// public final class Context {
//     private var authedUser: User?
//     private let conn: DatabaseConnection
//     init(authToken: String, conn: DatabaseConnection) throws {
//         self.conn = conn
//         let authenticator = try! Authenticator(conn: self.conn)
//         self.authedUser = try authenticator.validateToken(token: authToken)
//     }

//     init(conn: DatabaseConnection) {
//         self.conn = conn
//         self.authedUser = nil
//     }
    
//     public func getUser() -> User? {
//         self.authedUser
//     }
//     public func getDB() -> PostgresDatabase{
//         self.conn.getDB()
//     }
// }