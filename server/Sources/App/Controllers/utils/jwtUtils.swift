// import Foundation
// import SwiftJWT

// class JWTUtil {
//     private let privateKey: Data
//     private let publicKey: Data
//     init() throws {
//         do {
//             // let privateKeyPath = URL(fileURLWithPath: getAbsolutePath(relativePath: "../../../../privateKey.key"))
//             let privateKeyPath = URL(fileURLWithPath: "/Users/bin315a1/Documents/1_UCLA/130_cs/project/ToolPool/server/privateKey.key")
//             self.privateKey = try Data(contentsOf: privateKeyPath, options: .alwaysMapped)
//             let publicKeyPath = URL(fileURLWithPath: "/Users/bin315a1/Documents/1_UCLA/130_cs/project/ToolPool/server/privateKey.key.pub")
//             self.publicKey = try Data(contentsOf: publicKeyPath, options: .alwaysMapped)
//         } catch let error as NSError {
//             print("public/private keys not initialized, check README for generating RSA keyfiles")
//             throw error
//         }
//     }
//     struct tokenClaims: Claims {
//         let id: String
//         let exp: Date
//     }

//     func createToken(userId: String) -> String {
//         let sampleHeader =  Header()
//         let sampleTokenPayload = tokenClaims(id:userId, exp: Date(timeIntervalSinceNow: 3600))
//         var smpaleJWT = JWT(header: sampleHeader, claims: sampleTokenPayload)
//         let jwtSigner = JWTSigner.rs256(privateKey: self.privateKey) // TODO: try factoring this out
//         do {
//             let signedJWT = try smpaleJWT.sign(using: jwtSigner)
//             return signedJWT
//         } catch {
//             print("wtf")
//             return ""
//         }
//         // print(signedJWT)
//         // return signedJWT
//     }

//     func validateToken(token: String) -> Bool {
//         let jwtVerifier = JWTVerifier.rs256(publicKey: self.publicKey)
//         do {
//             let result = try JWT<tokenClaims>(jwtString: token, verifier: jwtVerifier)
//             print(result.claims.id)
//             return true
//         } catch {
//             print("wtf")
//             return false
//         }
//     }
// }
