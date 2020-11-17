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
public struct User : Codable {
    public let id: Int
    public let name: String
    public let phoneNumber: String
    public let email: String
    
    public func getOwnedTools(context: Context, arguments: NoArguments) -> EventLoopFuture<[Tool]>{
        context.getDB().query("SELECT *, location[0] as lat, location[1] as lon FROM tools WHERE owner = $1",
                              [PostgresData(int: self.id)]).map{result in
            result.rows.map{ row in
                try! row.sql().decode(model: DBTool.self).toTool()
            }
        }
    }
    public func getBorrowHistory(context: Context, arguments: NoArguments) -> EventLoopFuture<[Borrow]>{
        context.getDB().query("SELECT *, LOWER(loan_period) AS loan_start, UPPER(loan_period) as loan_end FROM borrow WHERE \"user\" = $1",
                              [PostgresData(int: self.id)]).map{result in
            result.rows.map{row in
                try! row.sql().decode(model: DBBorrow.self).toBorrow()
            }
        }
    }
    public func getRatings(context: Context, arguments: NoArguments) -> EventLoopFuture<[UserRating]>{
        context.getDB().query("SELECT * FROM user_ratings WHERE reviewee = $1", [PostgresData(int: self.id)]).map{result in
            result.rows.map{row in
                try! row.sql().decode(model: DBUserRating.self).toUserRating()
            }
        }
    }
}
