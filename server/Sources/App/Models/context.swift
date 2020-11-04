//
//  Context.swift
//  
//
//  Created by Robert Geil on 10/24/20.
//

import Foundation
import PostgresKit
import NIO
struct DBUser: Codable {
    let name: String
    let user_id: Int64
}
public final class Context {
    let db: PostgresDatabase;
    let pools: EventLoopGroupConnectionPool<PostgresConnectionSource>;
    init(loop: EventLoopGroup) {
        let configuration = PostgresConfiguration(
            hostname: "127.0.0.1",
            port: 5432,
            username: "postgres",
            password: "FIef#9ipSFE9*",
            database: "postgres"
        )

        pools = EventLoopGroupConnectionPool(
            source: PostgresConnectionSource(configuration: configuration),
            on: loop
        )
        db = pools.database(logger: Logger(label: "Database Logger"))
    }
    public func getUser(id: Int) -> EventLoopFuture<User?> {
        return db.simpleQuery("SELECT * FROM users").map{ result in
            let user = try? result.first?.sql().decode(model: DBUser.self);
            if let user = user{
                return User(id: Int(user.user_id), name: user.name);
            }else{
                return nil;
            }
        }
    }
    public func getTool(id: Int) -> Tool?{
        Tool(id: id, condition: .new, owner: .init(id: 0, name: "Test User"))
    }
}
