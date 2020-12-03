//
//  dbconn.swift
//  
//
//  Created by Robert Geil on 11/6/20.
//

import Foundation
import PostgresKit
import NIO

class DatabaseController{
    let db: PostgresDatabase;
    let pools: EventLoopGroupConnectionPool<PostgresConnectionSource>;
    init(_ loop: EventLoopGroup, env: String) {
        print(env)
        let configuration = PostgresConfiguration(
            hostname: env == "production" ? "psql" : "localhost",
            port: env == "production" ? 5432 : 5433,
            username: "postgres",
            password: "FIef#9ipSFE9*",
            database: env == "testing" ? "testing" : "postgres"
        )

        pools = EventLoopGroupConnectionPool(
            source: PostgresConnectionSource(configuration: configuration),
            on: loop
        )
        db = pools.database(logger: Logger(label: "Database Logger"))
    }
    
    public func getDB() -> PostgresDatabase{
        db
    }
    public func shutdown(){
        pools.shutdown()
    }
}
