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
    init(authToken: String, conn: DatabaseConnection) throws {
        self.conn = conn
        let authenticator = try! Authenticator(conn: self.conn)
        let userFuture = try authenticator.validateToken(token: authToken)
        userFuture.whenSuccess({map in
            self.authedUser = map
        })
    }
    
    public func getUser() -> User? {
        return self.authedUser
    }
    public func getDB() -> PostgresDatabase{
        self.conn.getDB()
    }
}