@testable import App
import Foundation
import XCTVapor

final class AppTests: XCTestCase {
    func testHelloWorld() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)
        
        try app.test(.GET, "/", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "It works!")
        })
    }
}

final class LoginTests: XCTestCase{
    struct EmailPassword : Content{
        public let email: String
        public let password: String
    }
    func testMissingBody() throws{
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/login", afterResponse: {res in
            XCTAssertEqual(res.status, .unsupportedMediaType)
        })
    }
    func testMissingUser() throws{
        let app = Application(.testing)
        defer { app.shutdown()}
        try configure(app)
        try app.test(.POST, "/login",
                     beforeRequest: {req in
                        try req.content.encode(EmailPassword(email: "", password: ""))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .notFound)
                     })
    }
    func testExampleUser() throws{
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/login",
                     beforeRequest: {req in try req.content.encode(EmailPassword(email:"example@example.com", password: "password"))},
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertGreaterThan(res.body.string.count, 0)
                     }
        )
    }
}
final class SignupTest: XCTestCase{
    func testMissingBody() throws{
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/signup", afterResponse: {res in
            XCTAssertEqual(res.status, .unsupportedMediaType)
        })
    }
    struct NewUserInfo: Content{
        let email: String
        let password: String
        let name: String
        let phoneNumber: String
    }
    func testDuplicateEmail() throws{
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/signup",
                     beforeRequest: {req in try req.content.encode(NewUserInfo(email: "example@example.com", password: "password", name: "user1", phoneNumber: "1"))},
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .conflict)
                     }
        )
    }
}

struct GraphQLHTTPBody: Content {
    let query: String
    let operationName: String?
    let variables: [String: String]
}
final class QuerySelf: XCTestCase{
    func testSelfNotLoggedIn() throws{
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        try req.content.encode(GraphQLHTTPBody(query: "query Self{self{id}}", operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertEqual(res.body.string, "{\"data\":{\"self\":null}}")
                     })
    }
    func testLoggedInUser() throws{
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        let token = try Authenticator.instance.createToken(id: 1, name: "example", email: "example@example.com", phoneNumber: "11111111111")
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        req.headers.add(name: "Authorization", value: "Bearer \(token)")
                        try req.content.encode(GraphQLHTTPBody(query: "query Self{self{id}}", operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertEqual(res.body.string, "{\"data\":{\"self\":{\"id\":1}}}")
                     })
    }
}
final class QueryTests: XCTestCase{
    func testToolById() throws {
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        try req.content.encode(GraphQLHTTPBody(query: "query Tool1{tool(id: 1){id}}", operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertEqual(res.body.string, "{\"data\":{\"tool\":{\"id\":1}}}")
                     })
    }
    func testToolByIdWithOwnerAndVariable() throws {
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        try req.content.encode(GraphQLHTTPBody(query: "query Tool1($id: Int!){tool(id: $id){owner{name}}}", operationName: nil, variables: ["id":"1"]))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertEqual(res.body.string, "{\"data\":{\"tool\":{\"owner\":{\"name\":\"example\"}}}}")
                     })
    }
    func testToolByIdBorrowHistory() throws {
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        try req.content.encode(GraphQLHTTPBody(query: """
                        query Tool1{
                            tool(id: 1){
                                borrowHistory{
                                    loanPeriod{
                                        start
                                        end
                                    }
                                    user{
                                        name
                                    }
                                    tool{
                                        name
                                    }
                                }
                            }
                        }
                        """, operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertContains(res.body.string, "\"start\":0")
                        XCTAssertContains(res.body.string, "\"end\":1")
                        XCTAssertContains(res.body.string, "\"user\":{\"name\":\"example2\"}")
                        XCTAssertContains(res.body.string, "\"tool\":{\"name\":\"tool1\"}")
                     })
    }
}
