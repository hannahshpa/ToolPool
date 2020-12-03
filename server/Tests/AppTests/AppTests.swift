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
    func testCreateUser() throws{
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/signup",
                     beforeRequest: {req in try req.content.encode(NewUserInfo(email: "generatedUser@example.com", password: "password", name: "user1", phoneNumber: "1"))},
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertEqual(res.body.string, "success")
                        let _ = try app.database.query("DELETE FROM users WHERE email = 'generatedUser@example.com'").wait()
                     }
        )    }
}
