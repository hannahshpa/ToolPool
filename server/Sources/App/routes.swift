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

var db: DatabaseConnection? = nil
func routes(_ app: Application) throws {
    db = DatabaseConnection(loop: app.eventLoopGroup)

    let userController = UserController(conn: db!)
    let resolver = Resolver(conn: db!)
    let api = try! GQLAPI(resolver: resolver)
    app.get { req in
        return "It works!"
    }

    // Sign Up
    app.post("signup") {req -> EventLoopFuture<Response> in
        let httpBody = try req.content.decode(SignupHTTPBody.self)
        let promise = req.eventLoop.makePromise(of: Response.self)

        let signupFuture = userController.signup(httpBody)

        signupFuture.whenFailure({ error in
            promise.fail(error)
        })

        signupFuture.whenSuccess({ error in
            promise.succeed(.init(status: .ok, version: .init(major: 1, minor: 1), headers: .init([("Content-Type", "application/json")]), body: .init(string: "success")))
        })

        return promise.futureResult
    }

    // Login
    app.post("login"){req -> EventLoopFuture<Response> in
        let httpBody = try req.content.decode(LoginHTTPBody.self)
        let promise = req.eventLoop.makePromise(of: Response.self)

        let loginFuture = userController.login(httpBody)

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
        let promise = req.eventLoop.makePromise(of: Response.self)
        let tokenHeader = req.headers["Authorization"][0]
        let httpBody = try req.content.decode(GraphQLHTTPBody.self)
        var context: Context
        do {
            let tokenStringArray = tokenHeader.components(separatedBy: " ")
            if tokenStringArray.count != 2 || tokenStringArray[0] != "Bearer" {
                throw RequestError.invalidAuthToken
            }
            let authToken = tokenStringArray[1]
            context = try Context(authToken: authToken, conn: db!) // TODO: User authentication
        } catch AuthenticationError.invalidToken, RequestError.invalidAuthToken {
            promise.fail(RequestError.invalidAuthToken)
            return promise.futureResult
        } catch DecodingError.valueNotFound {
            promise.fail(RequestError.missingAuthToken)
            return promise.futureResult
        }

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
