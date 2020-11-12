//
//  Context.swift
//  
//
//  Created by Robert Geil on 10/24/20.
//

import Foundation
import PostgresKit

public final class Context {
    private let authedUser: User?
    private let conn: DatabaseConnection
    init(authedUser: User?, conn: DatabaseConnection){
        self.authedUser = authedUser
        self.conn = conn
    }
    
    public func getUser() -> User? {
        self.authedUser
    }
    public func getDB() -> PostgresDatabase{
        self.conn.getDB()
    }
}
