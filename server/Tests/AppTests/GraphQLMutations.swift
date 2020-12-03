@testable import App
import Foundation
import XCTVapor

final class CreateTool: XCTestCase{
    func testCreateToolWithNoUser() throws{
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        try req.content.encode(GraphQLHTTPBody(query: """
                                        mutation AddTool{
                                            addTool(tool: {name:"foo", description:"bar", condition:new,
                                                    location:{lat:34.0448,lon:-118.4487},
                                                    hourlyCost: 5,ownerId: 1,
                                                    tags: ["foo", "bar"]
                                                }){
                                                id
                                            }
                                        }
                                        """, operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertContains(res.body.string, "\"message\":\"Abort.403: Forbidden\"")
                        XCTAssertContains(res.body.string, "errors")
                     })
    }
    func testCreateToolWithMismatchedUser() throws{
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        let token = try Authenticator.instance.createToken(id: 1, name: "example", email: "example@example.com", phoneNumber: "11111111111")
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        req.headers.add(name: "Authorization", value: "Bearer \(token)")
                        try req.content.encode(GraphQLHTTPBody(query: """
                                        mutation AddTool{
                                            addTool(tool: {name:"foo", description:"bar", condition:new,
                                                    location:{lat:34.0448,lon:-118.4487},
                                                    hourlyCost: 5,ownerId: 2,
                                                    tags: ["foo", "bar"]
                                                }){
                                                id
                                            }
                                        }
                                        """, operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertContains(res.body.string, "\"message\":\"Abort.400: Bad Request\"")
                        XCTAssertContains(res.body.string, "errors")
                     })
    }
    func testCreateToolNoTags() throws{
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        let token = try Authenticator.instance.createToken(id: 1, name: "example", email: "example@example.com", phoneNumber: "11111111111")
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        req.headers.add(name: "Authorization", value: "Bearer \(token)")
                        try req.content.encode(GraphQLHTTPBody(query: """
                                        mutation AddTool{
                                            addTool(tool: {name:"createdTool", description:"bar", condition:new,
                                                    location:{lat:34.0448,lon:-118.4487},
                                                    hourlyCost: 5,ownerId: 1,
                                                    tags: []
                                                }){
                                                id
                                            }
                                        }
                                        """, operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertContains(res.body.string, "\"message\":\"Abort.400: At least 1 tag must be attached!\"")
                        XCTAssertContains(res.body.string, "errors")
                     })
    }
    func testCreateToolSuccess() throws{
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        let token = try Authenticator.instance.createToken(id: 1, name: "example", email: "example@example.com", phoneNumber: "11111111111")
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        req.headers.add(name: "Authorization", value: "Bearer \(token)")
                        try req.content.encode(GraphQLHTTPBody(query: """
                                        mutation AddTool{
                                            addTool(tool: {name:"createdTool", description:"bar", condition:new,
                                                    location:{lat:34.0448,lon:-118.4487},
                                                    hourlyCost: 5,ownerId: 1,
                                                    tags: ["foo", "bar"]
                                                }){
                                                id
                                            }
                                        }
                                        """, operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertContains(res.body.string, "{\"data\":{\"addTool\":{\"id\":")
                        let _ = try app.database.query("DELETE FROM tools WHERE owner = 1 AND name = 'createdTool'").wait()
                     })
    }
}
