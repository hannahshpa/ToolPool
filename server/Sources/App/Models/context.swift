//
//  Context.swift
//  
//
//  Created by Robert Geil on 10/24/20.
//

import Foundation

public final class Context {
    let authedUser: User?
    init(authedUser: User?){
        self.authedUser = authedUser
    }
    
    public func getUser() -> User? {
        return self.authedUser
    }
}
