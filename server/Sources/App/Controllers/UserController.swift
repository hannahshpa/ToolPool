import Vapor
import PostgresKit
import NIO


final class UserController {
    private let conn: DatabaseConnection
    private let authenticator: Authenticator

    init(conn: DatabaseConnection) {
        self.conn = conn
        self.authenticator = try! Authenticator(conn: self.conn)
    }

    func login(_ data: LoginHTTPBody) -> EventLoopFuture<String>{
        let email: String? = data.email
        let password: String? = data.password
        let hashedPassword = secureHashFunc(plainText: password!)
        var authToken: String
        do {
            authToken = try self.authenticator.createToken(userId: email!)
        } catch {
            return self.conn.getDB().eventLoop.makeFailedFuture(Abort(.internalServerError))
        }
        return conn.getDB().query("SELECT password FROM users WHERE email = $1", [PostgresData(string: email!)]).flatMap{result in
            let user = result.first
            if user == nil {
                return self.conn.getDB().eventLoop.makeFailedFuture(Abort(.notFound))
            }
            if user!.column("password")!.string! != hashedPassword{
                return self.conn.getDB().eventLoop.makeFailedFuture(Abort(.forbidden))
            }
            return self.conn.getDB().eventLoop.makeSucceededFuture(authToken)
        }
    }
    
    func signup(_ data: SignupHTTPBody) -> EventLoopFuture<Bool> {
        let email: String? = data.email
        let password: String? = data.password
        let name: String? = data.name
        let phoneNumber: String? = data.phoneNumber
        let hashedPassword = secureHashFunc(plainText: password!)
        return self.conn.getDB().query("SELECT user_id FROM users WHERE email = $1;",
            [PostgresData(string: email!)]).flatMap{result in
                let user = result.first
                if user == nil {
                    return self.conn.getDB().query("INSERT INTO users (name, password, phone_number, email) VALUES ($1, $2, $3, $4);",
                                              [PostgresData(string: name!),
                                               PostgresData(string: hashedPassword),
                                               PostgresData(string: phoneNumber!),
                                               PostgresData(string: email!)]).map{_ in true }
                } else {
                    return self.conn.getDB().eventLoop.makeFailedFuture(Abort(.conflict))
                }
        }
    }

    private func secureHashFunc(plainText: String) -> String{
        let digest = SHA256.hash(data: Data(plainText.utf8))
        let stringHash = digest.map { String(format: "%02hhx", $0) }.joined()
        return stringHash
    }
}
