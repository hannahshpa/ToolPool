//
//  Tool.swift
//  
//
//  Created by Robert Geil on 11/16/20.
//

import Foundation
import NIO
import PostgresKit
import Graphiti

public struct Tool: Codable{
    public let id: Int
    public let description: String
    public let name: String
    public let condition: ToolCondition
    public let location: GeoLocation
    public let ownerId: Int
    public let hourlyCost: Double
    
    public func getOwner(ctx: Context, arguments: NoArguments) -> EventLoopFuture<User>{
        DBUser.getById(id: self.ownerId, db: ctx.db).map{user in user!}
    }
    public func getImages(ctx: Context, arguments: NoArguments) -> EventLoopFuture<[String]>{
        ctx.db.query("SELECT * FROM tool_images WHERE tool = $1", [PostgresData(int: self.id)]).map{ result in
            result.rows.map{row in
                try! row.sql().decode(model: DBToolImages.self).image_uri
            }
        }
    }
    public func getTags(ctx: Context, arguments: NoArguments) -> EventLoopFuture<[String]>{
        ctx.db.query("SELECT * FROM tool_tags WHERE tool = $1", [PostgresData(int: self.id)]).map{ result in
            result.rows.map{row in
                try! row.sql().decode(model: DBToolTags.self).tag
            }
        }
    }
    public func getBorrowHistory(ctx: Context, arguments: NoArguments) -> EventLoopFuture<[Borrow]>{
        ctx.db.query("SELECT *, LOWER(loan_period) AS loan_start, UPPER(loan_period) as loan_end FROM borrow WHERE tool = $1",
                              [PostgresData(int: self.id)]).map{ result in
            result.rows.map{row in
                try! row.sql().decode(model: DBBorrow.self).toBorrow()
            }
        }
    }
    public func getRatings(ctx: Context, arguments: NoArguments) -> EventLoopFuture<[ToolRating]>{
        ctx.db.query("SELECT * FROM tool_ratings WHERE tool = $1", [PostgresData(int: self.id)]).map{result in
            result.rows.map{row in
                try! row.sql().decode(model: DBToolRating.self).toToolRating()
            }
        }
    }
    public func getSchedule(ctx: Context, arguments: NoArguments) -> EventLoopFuture<[TimeSlot]>{
        ctx.db.query("SELECT *, LOWER(period) as slot_start, UPPER(period) as slot_end FROM tool_schedule WHERE tool = $1", [PostgresData(int: self.id)]).map{result in
            result.rows.map{ row in
                try! row.sql().decode(model: DBToolSchedule.self).toTimeSlot()
            }
        }
    }
    public func getAverageRating(ctx: Context, arguments: NoArguments) -> EventLoopFuture<Double>{
        ctx.db.query("SELECT COALESCE(AVG(rating), 0) as avg FROM tool_ratings WHERE tool = $1;", [self.id.postgresData!]).map{result in
            result.first!.column("avg")!.double!
        }
    }
}
