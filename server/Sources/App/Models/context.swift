//
//  Context.swift
//  
//
//  Created by Robert Geil on 10/24/20.
//

import Foundation
public final class Context {
    public func getUser(id: Int) -> User? {
        User(id: id, name: "Foobar")
    }
    public func getTool(id: Int) -> Tool?{
        Tool(id: id, condition: .new, owner: .init(id: 0, name: "Test User"))
    }
}
