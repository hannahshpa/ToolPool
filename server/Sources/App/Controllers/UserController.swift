import Vapor
import PostgresKit
import NIO


final class UserController {
    private let db: PostgresDatabase
    private let authenticator: Authenticator

    init(db: PostgresDatabase) {
        self.db = db
        self.authenticator = try! Authenticator(db: db)
    }

    func login(_ data: LoginHTTPBody) -> EventLoopFuture<String>{
        let email: String? = data.email
        let password: String? = data.password
        let hashedPassword = secureHashFunc(plainText: password!)

        return self.db.query("SELECT * FROM users WHERE email = $1", [PostgresData(string: email!)]).flatMap{result in
            let user = result.first
            if user == nil {
                return self.db.eventLoop.makeFailedFuture(Abort(.notFound))
            }
            if user!.column("password")!.string! != hashedPassword{
                return self.db.eventLoop.makeFailedFuture(Abort(.forbidden))
            }

            let id = Int(user!.column("user_id")!.string!)!
            let name = user!.column("name")!.string!
            let email = user!.column("email")!.string!
            let phoneNumber = user!.column("phone_number")!.string!
            do {
                let authToken = try self.authenticator.createToken(id: id, name: name, email: email, phoneNumber: phoneNumber)
                return self.db.eventLoop.makeSucceededFuture(authToken)
            } catch {
                return self.db.eventLoop.makeFailedFuture(Abort(.internalServerError))
            }
        }
    }
    
    func signup(_ data: SignupHTTPBody) -> EventLoopFuture<Bool> {
        let email: String? = data.email
        let password: String? = data.password
        let name: String? = data.name
        let phoneNumber: String? = data.phoneNumber
        let hashedPassword = secureHashFunc(plainText: password!)
        return db.query("SELECT user_id FROM users WHERE email = $1;",
            [PostgresData(string: email!)]).flatMap{result in
                let user = result.first
                if user == nil {
                    return self.db.query("INSERT INTO users (name, password, phone_number, email) VALUES ($1, $2, $3, $4);",
                                              [PostgresData(string: name!),
                                               PostgresData(string: hashedPassword),
                                               PostgresData(string: phoneNumber!),
                                               PostgresData(string: email!)]).map{_ in true }
                } else {
                    return self.db.eventLoop.makeFailedFuture(Abort(.conflict))
                }
        }
    }

    private func secureHashFunc(plainText: String) -> String{
        let digest = SHA256.hash(data: Data(plainText.utf8))
        let stringHash = digest.map { String(format: "%02hhx", $0) }.joined()
        return stringHash
    }
}
