//
//  SignInView.swift
//  ToolPool
//
//  Created by Olsen on 11/4/20.
//

import SwiftUI
import Foundation

struct SignInView: View {
    @State var username: String = ""
    @State var password: String = ""
    var body: some View {
        VStack {
          Text(/*@START_MENU_TOKEN@*/"ToolPool"/*@END_MENU_TOKEN@*/)
            .font(.largeTitle)
           /* .onAppear() {
                loginAuth()
            }*/
          Form {
            Section(header: Text("Log in info")) {
              TextField("Username", text: $username)
              TextField("Password", text: $password)
            }
          }
          NavigationLink(destination: InAppView()) {
            Button(action: {
                loginAuth(un: username, pw: password)
               // self.mode.wrappedValue.dismiss()
            }) { Text("Enter")
                .foregroundColor(Color.black)
                .lineLimit(nil)
                .frame(width: 200.0)
                .background(Color.white)
                .padding()
                .border(Color.black, width:2)
            }
          }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}


func loginAuth (un: String, pw:String) {
    var semaphore = DispatchSemaphore (value: 0)

    let parameters = [
      [
        "key": "email",
        "value": un,
        "type": "text"
      ],
      [
        "key": "password",
        "value": pw,
        "type": "text"
      ]] as [[String : Any]]
    let boundary = "Boundary-\(UUID().uuidString)"
    var body = ""
    var error: Error? = nil
    for param in parameters {
      if param["disabled"] == nil {
        let paramName = param["key"]!
        body += "--\(boundary)\r\n"
        body += "Content-Disposition:form-data; name=\"\(paramName)\""
        let paramType = param["type"] as! String
        if paramType == "text" {
          let paramValue = param["value"] as! String
          body += "\r\n\r\n\(paramValue)\r\n"
        } else {
          let paramSrc = param["src"] as! String
          let fileData = try? NSData(contentsOfFile:paramSrc, options:[]) as Data
            let fileContent = String(data: fileData!, encoding: .utf8)!
          body += "; filename=\"\(paramSrc)\"\r\n"
            + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
        }
      }
    }
    body += "--\(boundary)--\r\n";
    let postData = body.data(using: .utf8)

    var request = URLRequest(url: URL(string: "http://0.0.0.0:8000/login")!,timeoutInterval: Double.infinity)
    request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

    request.httpMethod = "POST"
    request.httpBody = postData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        return
      }
      print("token: " + String(data: data, encoding: .utf8)!)
      semaphore.signal()
    }

    task.resume()
    semaphore.wait()
}

struct Credentials {
   var token: String
}
enum KeychainError: Error {
    case
        noPassword
    case
        unexpectedPasswordData
    case unhandledError(status:OSStatus)
}

