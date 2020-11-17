import Foundation
import GraphQL
import Graphiti
import Vapor

struct GraphQLHTTPBody: Decodable {
    let query: String
    let operationName: String?
    let variables: [String: Map]
}
var db: DatabaseConnection? = nil
func routes(_ app: Application) throws {
    db = DatabaseConnection(loop: app.eventLoopGroup)
    let resolver = Resolver(conn: db!)
    let api = try! GQLAPI(resolver: resolver)
    app.get { req in
        return "It works!"
    }

    // Login
    app.post("login"){req -> EventLoopFuture<Response> in
        let promise = req.eventLoop.makePromise(of: Response.self)
//         let future = auth!.login(email: "", password: "")
//         future.whenSuccess{ result in
//             promise.succeed(.init(status: .ok, version: .init(major: 1, minor: 1), headers: .init([("Content-Type", "application/json")]), body: .init(string: "{\"token\":\"\(result)\"}")))
//         }
//         future.whenFailure{error in
//             promise.succeed(.init(status: .ok, version: .init(major: 1, minor: 1), headers: .init([("Content-Type", "application/json")]), body: .init(string: "{\"error\":\"\(error)\"}")))
//         }
        let authenticator = Authenticator(conn: db!)
        authenticator.tester()
        promise.succeed(.init(status: .ok, version: .init(major: 1, minor: 1), headers: .init([("Content-Type", "application/json")]), body: .init(string: "sample")))
        return promise.futureResult
    }

    // GraphQL queries
    app.post("graphql"){req -> EventLoopFuture<Response> in
        let httpBody = try req.content.decode(GraphQLHTTPBody.self)
        let promise = req.eventLoop.makePromise(of: Response.self)
        let context = Context(authedUser: nil, conn: db!) // TODO: User authentication
        
        let graphQLFuture = api.schema.execute(
            request: httpBody.query,
            resolver: resolver,
            context: context,
            eventLoopGroup: req.eventLoop,
            variables: httpBody.variables,
            operationName: httpBody.operationName
        )
        
        graphQLFuture.whenFailure({ error in
            promise.fail(error)
        })
        
        graphQLFuture.whenSuccess({ map in
            promise.succeed(Response(status: .ok,
                                     version: .init(major: 1, minor: 1),
                                     headers: .init([("Content-Type", "application/json")]),
                                     body: .init(string: map.description)))
        })
        
        return promise.futureResult
    }
}
