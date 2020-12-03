@testable import App
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
}
