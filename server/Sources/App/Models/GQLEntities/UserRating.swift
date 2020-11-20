//
//  User.swift
//  
//
//  Created by Robert Geil on 11/16/20.
//

import Foundation
import NIO
import PostgresKit
import Graphiti

public struct UserRating: Codable{
    public let reviewerId: Int
    public let revieweeId: Int
    public let rating: Int
    public let review: String?
    
    public func getReviewer(context: Context, arguments: NoArguments) -> EventLoopFuture<User>{
        DBUser.getById(id: self.reviewerId, db: context.getDB()).map{ user in user!}
    }
    public func getReviewee(context: Context, arguments: NoArguments) -> EventLoopFuture<User>{
        DBUser.getById(id: self.revieweeId, db: context.getDB()).map{ user in user!}
    }
}
