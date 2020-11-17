import Vapor
import PostgresKit
import NIO
import authenticator


final class UserController {
    init() {}

    func login(_ req: Request) -> EventLoopFuture<String?>{
        let httpBody = req.json
        let Authenticator = authenticator()
        
        // get username from http request body
        let email: String? = httpBody["email"]

       // get password from http request body
        let password: String? = httpBody["password"]
        
        if let token = try? authenticator.login(email, password) {
                return token
            } else {
                return nil
            }
        }
    
    func signup(_ req: Request) -> EventLoopFuture<String?> {
        let conn: DatabaseConnection = db!
        // grab http body
        let httpBody = req.json
        
        // get username from http request body
        let email: String? = httpBody["email"]

      // get password from http request body
        let password: String? = httpBody["password"]
        
      // get name from http request body
        let name: String? = httpBody["name"]
        
      // get phone_number from http request body
        let phone_number: String? = httpBody["phone_number"]
        
      
        // 1. hash the password
        let shadow = secureHashFunc(plaintext: password)
        // 2. check if the username exits by querying for user and comparing password
        return conn.getDB().query("SELECT user_id FROM users WHERE email = $1;",
            [PostgresData(string: email)]).flatMap{result in
                let userFromDB = result.first!.column("password")!.string!
                if userFromDB == nil {
                    //3. create an entry in the db
                    return conn.getDB().query("INSERT INTO users (name, password, phone_number, email) VALUES ($1, $2, $3, $4);",
                                              [PostgresData(string: name),
                                               PostgresData(string: password),
                                               PostgresData(string: phone_number),
                                               PostgresData(string: email)])..map{_ in true }
                    //TODO return a jwt token
                }
                // error, there was a user already created with those credentials
                return self.conn.getDB().eventLoop.makeSucceededFuture(nil)
        }
    }
}
