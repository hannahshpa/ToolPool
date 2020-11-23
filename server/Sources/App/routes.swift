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

struct uploadImageHTTPBody: Decodable {
    let toolId: String
}

struct GraphQLHTTPBody: Decodable {
    let query: String
    let operationName: String?
    let variables: [String: Map]
}

var db: DatabaseConnection? = nil
var userController: UserController? = nil
var s3: S3Uploader? = nil

func routes(_ app: Application) throws {
    db = DatabaseConnection(loop: app.eventLoopGroup)
    userController = UserController(conn: db!)
    s3 = S3Uploader()
    
    let resolver = Resolver(conn: db!)
    let api = try! GQLAPI(resolver: resolver)
    app.get { req in
        return "It works!"
    }

    // Sign Up
    app.post("signup") {req -> EventLoopFuture<Response> in
        let httpBody = try req.content.decode(SignupHTTPBody.self)
        let promise = req.eventLoop.makePromise(of: Response.self)

        let signupFuture = userController!.signup(httpBody)

        signupFuture.whenFailure({ error in
            promise.fail(error)
        })

        signupFuture.whenSuccess({ map in
            promise.succeed(.init(status: .ok, version: .init(major: 1, minor: 1), headers: .init([("Content-Type", "application/json")]), body: .init(string: "success")))
        })

        return promise.futureResult
    }

    app.post("uploadImage") { req -> EventLoopFuture<Response> in
        let httpBody = try req.content.decode(uploadImageHTTPBody.self)
        let promise = req.eventLoop.makePromise(of: Response.self)

        let uploadImage = s3!.uploadImage()

        uploadImage.whenFailure({ error in
            promise.fail(error)
        })

        uploadImage.whenSuccess { response in
            if let body = response.body {
                print(String(data: body, encoding: .utf8)!)
            }
            promise.succeed(.init(status: .ok, version: .init(major: 1, minor: 1), headers: .init([("Content-Type", "application/json")]), body: .init(string: "success")))
        }

        return promise.futureResult
    }

    // Login
    app.post("login"){req -> EventLoopFuture<Response> in
        let httpBody = try req.content.decode(LoginHTTPBody.self)
        let promise = req.eventLoop.makePromise(of: Response.self)

        let loginFuture = userController!.login(httpBody)

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

        var context: Context
        let authTokenGiven: Bool = req.headers["Authorization"].count == 0 ? false: true
        let httpBody = try req.content.decode(GraphQLHTTPBody.self)
        if authTokenGiven {
            let tokenHeader = req.headers["Authorization"][0]
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
        } else {
            context = Context(conn: db!)
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
