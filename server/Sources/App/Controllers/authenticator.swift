import Foundation
import PostgresKit
import Vapor
import SwiftJWT


class Authenticator{
    private let conn: DatabaseConnection

    private let privateKey: Data
    private let publicKey: Data
    private let jwtSigner: JWTSigner
    private let jwtVerifier: JWTVerifier

    struct tokenClaims: Claims {
        let id: String
        let exp: Date
    }

    init(conn: DatabaseConnection) throws {
        self.conn = conn
        let env = ProcessInfo.processInfo.environment["ENV"]
        var privateKeyPath: URL
        var publicKeyPath: URL
        do {
            if env == "production" {
                privateKeyPath = URL(fileURLWithPath: "/app/privateKey.key")
                publicKeyPath = URL(fileURLWithPath: "/app/privateKey.key.pub")
            } else {
                privateKeyPath = URL(fileURLWithPath: "./privateKey.key")
                publicKeyPath = URL(fileURLWithPath: "./privateKey.key.pub")
            }
            self.privateKey = try Data(contentsOf: privateKeyPath, options: .alwaysMapped)
            self.publicKey = try Data(contentsOf: publicKeyPath, options: .alwaysMapped)
            self.jwtSigner = JWTSigner.rs256(privateKey: self.privateKey)
            self.jwtVerifier = JWTVerifier.rs256(publicKey: self.publicKey)
        } catch let error as NSError {
            print("public/private keys not initialized, check README for generating RSA keyfiles")
            throw error
        }
    }

    func createToken(userId: String) throws -> String {
        let header =  Header()
        let tokenPayload = tokenClaims(id:userId, exp: Date(timeIntervalSinceNow: 3600))
        var jwt = JWT(header: header, claims: tokenPayload)
        do {
            let signedJWT = try jwt.sign(using: self.jwtSigner)
            return signedJWT
        } catch {
            throw AuthenticationError.authenticatorInternalError
        }
    }

    func validateToken(token: String) throws -> EventLoopFuture<User?> {
        do {
            let decodedJWT = try JWT<tokenClaims>(jwtString: token, verifier: self.jwtVerifier)

            let date = Date()
            if date > decodedJWT.claims.exp {
                throw AuthenticationError.invalidToken
            }

            let userEmail = decodedJWT.claims.id

            let userFuture = self.conn.getDB()
                .query("SELECT * FROM users WHERE email = $1",[PostgresData(string: userEmail)])
                .map{
                    result -> User? in
                    if let dbUser = try? result.first?.sql().decode(model: DBUser.self) {
                        return dbUser.toUser()
                    } else {
                        return nil
                    }
                }
            return userFuture
        } catch {
            throw AuthenticationError.invalidToken
        }
    }
}
