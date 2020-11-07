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
    
    public func getDB() -> PostgresDatabase{
        return db;
    }
}
