import Foundation
import PostgresKit
import Vapor

class Authenticator{
    private let conn: DatabaseConnection
//    private let jwt: JWT
    init(conn: DatabaseConnection) {
        self.conn = conn
//        self.jwt = JWT()
    }
    func login(email: String, password: String) -> EventLoopFuture<String?>{
        let shadow = secureHashFunc(plaintext: password)
            return conn.getDB().query("SELECT password FROM users WHERE email = $1", [PostgresData(string: email)]).flatMap{result in
                let dbshadow = result.first!.column("password")!.string!
                if dbshadow != shadow{
                    return self.conn.getDB().eventLoop.makeSucceededFuture(nil)
                }
                return self.generateAuthToken().map{result in result}
            }
        }
    func generateAuthToken() -> EventLoopFuture<String>{
         let token = "todo: generate jwt token"
//        let token = jwt.createToken()
//        print(token)
        return conn.getDB().query("INSERT INTO tokens (token, user_id) VALUES ($1, $2)", []).map{result in token}
    }

//    func userFromToken(token: String) -> EventLoopFuture<User?>{
//        return conn.getDB().query("SELECT * FROM tokens JOIN users WHERE expiration > NOW() AND $1 = tokens.token", [PostgresData(string: token)]).map{result in
//            if let user = try? results.first!.sql().decode(model: User.self) {
////                try! results.first!.sql().decode(model: SomeObject.self)
//                return user
//            } else
//            return self.conn.getDB().eventLoop.makeSucceededFuture(nil)
//        }
//    }

    func secureHashFunc(plaintext: String) -> String{
        let digest = SHA256.hash(data: Data(plaintext.utf8))
        print(digest)
        let stringHash = digest.map { String(format: "%02hhx", $0) }.joined()
        return stringHash
    }

    func tester() -> Void{
//        let sampleJWT = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
//        let myHeader = Header(kid: "KeyID1")
//        print(sampleJWT)
        let digest = SHA256.hash(data: Data("hello".utf8))
        print(digest)
        let stringHash = digest.map { String(format: "%02hhx", $0) }.joined()
        print(stringHash)
    }
}
