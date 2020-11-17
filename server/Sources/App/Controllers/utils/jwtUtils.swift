import SwiftJWT

class JWT {
    let PRIVATE_KEY = "randomPrivateKey"
    struct tokenClaims: Claims {
        let id: String
        let exp: Date
    }

    func createToken() -> String {
        let sampleHeader =  Header()
        let sampleTokenPayload = tokenClaims(id:"fakeId", exp: Date(timeIntervalSinceNow: 3600))
        let smpaleJWT = JWT(header: sampleHeader, claims: sampleTokenPayload)
        let jwtSigner = JWTSigner(privateKey: PRIVATE_KEY) // TODO: try factoring this out
        let signedJWT = try smpaleJWT.sign(using: jwtSigner)
        // print(signedJWT)
        return signedJWT
    }

    // func valid(token: String) -> Bool {
        
    // }
}