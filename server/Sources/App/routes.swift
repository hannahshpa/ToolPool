import Foundation
import GraphQL
import Graphiti
import Vapor


struct LoginHTTPBody: Decodable {
    var email: String
    var password: String
}

struct SignupHTTPBody: Decodable {
    let email: String
    let password: String
    let name: String
    let phoneNumber: String
}

struct GraphQLHTTPBody: Decodable {
    let query: String
    let operationName: String?
    let variables: [String: Map]
}

func routes(_ app: Application) throws {
    
    let resolver = Resolver()
    let api = try! GQLAPI(resolver: resolver)
    app.get { req in
        return "It works!"
    }

    // Sign Up
    app.post("signup") {req -> EventLoopFuture<Response> in
        let httpBody = try req.content.decode(SignupHTTPBody.self)
        let promise = req.eventLoop.makePromise(of: Response.self)

        let signupFuture = UserController.signup(httpBody, db: req.application.database)

        signupFuture.whenFailure({ error in
            promise.fail(error)
        })

        signupFuture.whenSuccess({ map in
            promise.succeed(.init(status: .ok, version: .init(major: 1, minor: 1), headers: .init([("Content-Type", "application/json")]), body: .init(string: "success")))
        })

        return promise.futureResult
    }

    // Login
    app.post("login"){req -> EventLoopFuture<Response> in
        let httpBody = try req.content.decode(LoginHTTPBody.self)
        let promise = req.eventLoop.makePromise(of: Response.self)

        let loginFuture = UserController.login(httpBody, db: req.application.database)

        loginFuture.whenFailure({ error in
            promise.fail(error)
        })
        loginFuture.whenSuccess({ map in
            promise.succeed(.init(status: .ok, version: .init(major: 1, minor: 1), headers: .init([("Content-Type", "application/json")]), body: .init(string: map.description)))
        })
        
        return promise.futureResult
    }


    // GraphQL queries
    app.post("graphql"){req -> EventLoopFuture<Response> in

        let authTokenGiven: Bool = req.headers["Authorization"].count != 0
        let httpBody = try req.content.decode(GraphQLHTTPBody.self)
        let context = authTokenGiven ?
            Context(app: req.application, user: try Authenticator.instance.validateToken(req.headers["Authorization"][0])) :
            Context(app: req.application)

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
