@testable import App
import Foundation
import XCTVapor

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
    func testSelfBadAuthToken() throws{
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        req.headers.add(name: "Authorization", value: "Bearer notatokenwhoops")
                        try req.content.encode(GraphQLHTTPBody(query: "query Self{self{id}}", operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .internalServerError)
                        XCTAssertContains(res.body.string, "error")
                     })
    }
    func testSelfNoBearerToken() throws{
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        let token = try Authenticator.instance.createToken(id: 1, name: "example", email: "example@example.com", phoneNumber: "11111111111")
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        req.headers.add(name: "Authorization", value: token)
                        try req.content.encode(GraphQLHTTPBody(query: "query Self{self{id}}", operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .internalServerError)
                        XCTAssertContains(res.body.string, "error")
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
    func testLoggedInUserGetTools() throws{
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        let token = try Authenticator.instance.createToken(id: 1, name: "example", email: "example@example.com", phoneNumber: "11111111111")
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        req.headers.add(name: "Authorization", value: "Bearer \(token)")
                        try req.content.encode(GraphQLHTTPBody(query: """
                        query Self{
                                self{
                                    ownedTools{
                                        id
                                        }
                                    }
                                }
                        """, operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertEqual(res.body.string, "{\"data\":{\"self\":{\"ownedTools\":[{\"id\":1}]}}}")
                     })
        
    }
    func testLoggedInUserGetEmptyBorrowHistory() throws{
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        let token = try Authenticator.instance.createToken(id: 1, name: "example", email: "example@example.com", phoneNumber: "11111111111")
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        req.headers.add(name: "Authorization", value: "Bearer \(token)")
                        try req.content.encode(GraphQLHTTPBody(query: """
                        query Self{
                                self{
                                    borrowHistory{
                                        id
                                        }
                                    }
                                }
                        """, operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertEqual(res.body.string, "{\"data\":{\"self\":{\"borrowHistory\":[]}}}")
                     })
        
    }
    func testLoggedInUserGetBorrowHistory() throws{
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        let token = try Authenticator.instance.createToken(id: 2, name: "example", email: "example2@example.com", phoneNumber: "11111111111")
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        req.headers.add(name: "Authorization", value: "Bearer \(token)")
                        try req.content.encode(GraphQLHTTPBody(query: """
                        query Self{
                                self{
                                    borrowHistory{
                                        tool{
                                            id
                                            }
                                        }
                                    }
                                }
                        """, operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertEqual(res.body.string, "{\"data\":{\"self\":{\"borrowHistory\":[{\"tool\":{\"id\":1}}]}}}")
                     })
    }
    func testLoggedInUserGetRatings() throws{
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        let token = try Authenticator.instance.createToken(id: 2, name: "example", email: "example2@example.com", phoneNumber: "11111111111")
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        req.headers.add(name: "Authorization", value: "Bearer \(token)")
                        try req.content.encode(GraphQLHTTPBody(query: """
                        query Self{
                                self{
                                    ratings{
                                        rating
                                        reviewer{id}
                                        reviewee{id}
                                        }
                                    }
                                }
                        """, operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertContains(res.body.string, "\"rating\":5")
                        XCTAssertContains(res.body.string, "\"reviewer\":{\"id\":1}")
                        XCTAssertContains(res.body.string, "\"reviewee\":{\"id\":2}")
                        XCTAssertContains(res.body.string, "{\"data\":{\"self\":{\"ratings\":[")
                     })
        
    }
}

final class QueryToolById: XCTestCase{
    func testBaseCase() throws {
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
    func testIdDoesntExist() throws {
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        try req.content.encode(GraphQLHTTPBody(query: "query Tool1{tool(id: 999){id}}", operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertEqual(res.body.string, "{\"data\":{\"tool\":null}}")
                     })
    }
    func testGetOwnerAndVariable() throws {
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
    func testGetRating() throws {
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        try req.content.encode(GraphQLHTTPBody(query: """
                        query Tool1{
                            tool(id: 1){
                                ratings{
                                    rating
                                    tool{id}
                                    user{id}
                                }
                            }
                        }
                        """, operationName: nil, variables: [String:String]()))                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertContains(res.body.string, "{\"data\":{\"tool\":{\"ratings\":[")
                        XCTAssertContains(res.body.string, "\"rating\":5")
                        XCTAssertContains(res.body.string, "\"tool\":{\"id\":1}")
                        XCTAssertContains(res.body.string, "\"user\":{\"id\":2}")
                     })
    }
    func testGetAverageRating() throws {
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        try req.content.encode(GraphQLHTTPBody(query: """
                        query Tool1{
                            tool(id: 1){
                                averageRating
                            }
                        }
                        """, operationName: nil, variables: [String:String]()))                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertEqual(res.body.string, "{\"data\":{\"tool\":{\"averageRating\":5}}}")
                     })
    }
    func testImages() throws {
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        try req.content.encode(GraphQLHTTPBody(query: """
                        query Tool1{
                            tool(id: 1){
                                images
                            }
                        }
                        """, operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertEqual(res.body.string, "{\"data\":{\"tool\":{\"images\":[\"image.example.com\"]}}}")
                     })
    }
    func testTags() throws {
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        try req.content.encode(GraphQLHTTPBody(query: """
                        query Tool1{
                            tool(id: 1){
                                tags
                            }
                        }
                        """, operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertEqual(res.body.string, "{\"data\":{\"tool\":{\"tags\":[\"outdoor\"]}}}")
                     })
    }
    
    
    func testBorrowHistory() throws {
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
    func testSchedule() throws {
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        try req.content.encode(GraphQLHTTPBody(query: """
                        query Tool1{
                            tool(id: 1){
                                schedule{
                                    start
                                    end
                                }
                            }
                        }
                        """, operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertContains(res.body.string, "\"start\":0")
                        XCTAssertContains(res.body.string, "\"end\":60")
                        XCTAssertContains(res.body.string, "{\"data\":{\"tool\":{\"schedule\":[")
                     })
    }
}

final class QueryNearby: XCTestCase{
    func testNoNearbyTools() throws {
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        try req.content.encode(GraphQLHTTPBody(query: """
                        query Nearby{
                            nearby(center: {lat: 1000, lon: 1000}, radius: 0){
                                id
                            }
                        }
                        """, operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertEqual(res.body.string, "{\"data\":{\"nearby\":[]}}")
                     })
    }
    func testNearbyToolExists() throws {
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        try req.content.encode(GraphQLHTTPBody(query: """
                        query Nearby{
                            nearby(center: {lat: 0, lon: 0}, radius: 1){
                                id
                            }
                        }
                        """, operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertContains(res.body.string, "{\"id\":1}")
                     })
    }
    func testNearbyToolExistsWithTag() throws {
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        try req.content.encode(GraphQLHTTPBody(query: """
                        query Nearby{
                            nearby(center: {lat: 0, lon: 0}, radius: 1, category: "outdoor"){
                                id
                            }
                        }
                        """, operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertContains(res.body.string, "{\"id\":1}")
                     })
    }
}


final class QueryBorrowById: XCTestCase{
    func testBorrowDoesntExist() throws {
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        try req.content.encode(GraphQLHTTPBody(query: """
                        query Borrow{
                            borrow(id: 999){
                                id
                            }
                        }
                        """, operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertEqual(res.body.string, "{\"data\":{\"borrow\":null}}")
                     })
    }
    func testBorrowExists() throws {
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        try req.content.encode(GraphQLHTTPBody(query: """
                        query Borrow{
                            borrow(id: 1){
                                id
                            }
                        }
                        """, operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertEqual(res.body.string, "{\"data\":{\"borrow\":{\"id\":1}}}")
                     })
    }
    func testBorrowGetTimeReturned() throws {
        let app = Application(.testing)
        defer {app.shutdown()}
        try configure(app)
        try app.test(.POST, "/graphql",
                     beforeRequest: {req in
                        try req.content.encode(GraphQLHTTPBody(query: """
                        query Borrow{
                            borrow(id: 1){
                                timeReturned
                            }
                        }
                        """, operationName: nil, variables: [String:String]()))
                     },
                     afterResponse: {res in
                        XCTAssertEqual(res.status, .ok)
                        XCTAssertFalse(res.body.string.contains("error"))
                        XCTAssertEqual(res.body.string, "{\"data\":{\"borrow\":{\"timeReturned\":1}}}")
                     })
    }
}
