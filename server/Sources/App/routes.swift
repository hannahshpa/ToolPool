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
