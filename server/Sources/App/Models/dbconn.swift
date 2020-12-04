//
//  dbconn.swift
//  
//
//  Created by Robert Geil on 11/6/20.
//

import Foundation
import PostgresKit
import NIO

class DatabaseConnection{
    let db: PostgresDatabase;
    let pools: EventLoopGroupConnectionPool<PostgresConnectionSource>;
    private static let instance: DatabaseConnection? = nil
    init(loop: EventLoopGroup) {
        let env = ProcessInfo.processInfo.environment["ENV"]
        let configuration = PostgresConfiguration(
            hostname: env == "production" ? "psql" : "localhost",
            port: env == "production" ? 5432 : 5432,
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
    
    public func getDB() -> PostgresDatabase{
        db
    }
}
