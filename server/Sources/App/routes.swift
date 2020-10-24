import Foundation
import GraphQL
import Graphiti
import Vapor
let resolver = Resolver()
let context = Context()
let api = try! GQLAPI(resolver: resolver)

struct GraphQLHTTPBody: Decodable {
    let query: String
    let operationName: String?
    let variables: [String: Map]
}

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    app.post("graphql"){req -> EventLoopFuture<Response> in
        let httpBody = try req.content.decode(GraphQLHTTPBody.self)
        let promise = req.eventLoop.makePromise(of: Response.self)
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
