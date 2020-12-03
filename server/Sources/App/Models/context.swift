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
    private let _db: PostgresDatabase
    public var db: PostgresDatabase {
        get{_db}
    }
    init(authToken: String, db: PostgresDatabase) throws {
        _db = db
        let authenticator = try! Authenticator(db: self.db)
        self.authedUser = try authenticator.validateToken(token: authToken)
    }

    init(db: PostgresDatabase) {
        _db = db
        self.authedUser = nil
    }
    
    public func getUser() -> User? {
        self.authedUser
    }
}
