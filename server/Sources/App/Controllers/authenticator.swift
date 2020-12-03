import Foundation
import PostgresKit
import Vapor
import SwiftJWT


class Authenticator{
    private let db: PostgresDatabase

    private let privateKey: Data
    private let publicKey: Data
    private let jwtSigner: JWTSigner
    private let jwtVerifier: JWTVerifier

    struct tokenClaims: Claims {
        let id: String
        let email: String
        let name: String
        let phoneNumber: String
        let exp: Date
    }

    init(db: PostgresDatabase) throws {
        self.db = db
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

    func createToken(id: Int, name: String, email: String, phoneNumber: String) throws -> String {
        let header =  Header()
        let id_str = String(id)
        let tokenPayload = tokenClaims(
            id: id_str,
            email: email,
            name: name,
            phoneNumber: phoneNumber,
            exp: Date(timeIntervalSinceNow: 3600))
        var jwt = JWT(header: header, claims: tokenPayload)
        do {
            let signedJWT = try jwt.sign(using: self.jwtSigner)
            return signedJWT
        } catch {
            throw AuthenticationError.authenticatorInternalError
        }
    }

    func validateToken(token: String) throws -> User? {
        do {
            let decodedJWT = try JWT<tokenClaims>(jwtString: token, verifier: self.jwtVerifier)
            let payload = decodedJWT.claims
            let date = Date()
            if date > payload.exp {
                throw AuthenticationError.invalidToken
            }
            let id_int = Int(payload.id)!

            let user = User(id: id_int, name: payload.name, phoneNumber: payload.phoneNumber, email: payload.email)
            return user
        } catch {
            throw AuthenticationError.invalidToken
        }
    }
}
