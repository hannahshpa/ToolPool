import Vapor
import PostgresKit
extension Application{
    public struct Database{
        let application: Application
        struct Lifecycle: LifecycleHandler{
            func shutdown(_ application: Application) {
                print("Shutting down")
                application.db.storage.pools.shutdown()
            }
        }
        func initialize(){
            self.application.storage[Key.self] = DatabaseController(application.eventLoopGroup)
            self.application.lifecycle.use(Lifecycle())
        }
        struct Key: StorageKey {
            typealias Value = DatabaseController
        }
        var storage: DatabaseController {
            if self.application.storage[Key.self] == nil {
                self.initialize()
            }
            return self.application.storage[Key.self]!
        }
    }
    public var db: Database {
        .init(application: self)
    }
    public var database: PostgresDatabase{
        self.db.storage.getDB()
    }
}

public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    // register routes
    try routes(app)
}

