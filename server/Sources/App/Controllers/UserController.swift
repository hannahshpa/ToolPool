import Vapor
import PostgresKit
import NIO


final class UserController {
    
    static func login(_ data: LoginHTTPBody, db: PostgresDatabase) -> EventLoopFuture<String>{
        db.query("SELECT * FROM users WHERE email = $1 AND password = $2", [data.email.postgresData!, secureHashFunc(data.password).postgresData!]).flatMap{result in
            guard let user = try! result.first?.sql().decode(model: DBUser.self) else {
                return db.eventLoop.makeFailedFuture(Abort(.notFound))
            }
            do {
                let authToken = try Authenticator.instance.createToken(id: user.user_id, name: user.name, email: user.email, phoneNumber: user.phone_number)
                return db.eventLoop.makeSucceededFuture(authToken)
            } catch {
                return db.eventLoop.makeFailedFuture(Abort(.internalServerError))
            }
        }
    }
    
    static func signup(_ data: SignupHTTPBody, db: PostgresDatabase) -> EventLoopFuture<Bool> {
        db.query("SELECT user_id FROM users WHERE email = $1;", [data.email.postgresData!]).flatMap{result in
            let user = result.first
            if user == nil {
                return db.query("INSERT INTO users (name, password, phone_number, email) VALUES ($1, $2, $3, $4);",
                                [data.name.postgresData!,
                                 secureHashFunc(data.password).postgresData!,
                                 data.phoneNumber.postgresData!,
                                 data.email.postgresData!]).map{_ in true }
            } else {
                return db.eventLoop.makeFailedFuture(Abort(.conflict))
            }
        }
    }
    
    private static func secureHashFunc(_ plainText: String) -> String{
        let digest = SHA256.hash(data: Data(plainText.utf8))
        let stringHash = digest.map { String(format: "%02hhx", $0) }.joined()
        return stringHash
    }
}
