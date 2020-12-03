//
//  Context.swift
//  
//
//  Created by Robert Geil on 10/24/20.
//

import Foundation
import PostgresKit
import Vapor
public final class Context {
    private let _user: User?
    private let _app: Application
    public var db: PostgresDatabase {
        _app.database
    }
    public var eventLoop: EventLoop{
        _app.eventLoopGroup.next()
    }
    public var user: User?{
        _user
    }
    
    init(app: Application, user: User? = nil) {
        self._app = app
        self._user = user
    }
}
