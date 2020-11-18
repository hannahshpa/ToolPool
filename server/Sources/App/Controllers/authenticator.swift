import Foundation
import PostgresKit
import Vapor

class Authenticator{
    private let conn: DatabaseConnection
    private let jwt: JWTUtil
    init(conn: DatabaseConnection) {
        self.conn = conn
        self.jwt = try! JWTUtil()
    }
    // func login(email: String, password: String) -> EventLoopFuture<String?>{
    //     let shadow = secureHashFunc(plaintext: password)
    //     return conn.getDB().query("SELECT password FROM users WHERE email = $1", [PostgresData(string: email)]).flatMap{result in
    //         let dbshadow = result.first!.column("password")!.string!
    //         if dbshadow != shadow{
    //             return self.conn.getDB().eventLoop.makeSucceededFuture(nil)
    //         }
    //         return self.generateAuthToken().map{result in result}
    //     }
    // }
//     func generateAuthToken() -> EventLoopFuture<String>{
//         // let token = "todo: generate jwt token"
//         let token = jwt.createToken()
//         print(token)
//         return conn.getDB().query("INSERT INTO tokens (token, user_id) VALUES ($1, $2)", []).map{result in token}
//     }
    func userFromToken(token: String) -> EventLoopFuture<User?>{
        return conn.getDB().query("SELECT * FROM tokens JOIN users WHERE expiration > NOW()").map{result in
            return nil // TODO: Get the user, if exists
        }
    }

//     func secureHashFunc(plaintext: String) -> String{
//         let digest = SHA256.hash(data: Data(plaintext.utf8))
//         print(digest)
//         let stringHash = hash.map { String(format: "%02hhx", digest) }.joined()
//         return stringHash
//     }

    func tester() -> Void{
        let sampleJWT = self.jwt.createToken(userId: "fakeId")
        print(self.jwt.validateToken(token: sampleJWT))
    }
}
