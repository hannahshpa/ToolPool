//
//  CreateAccountView.swift
//  ToolPool
//
//  Created by Olsen on 11/4/20.
//

import SwiftUI

struct CreateAccountView: View {
  @State var username: String = ""
  @State var password: String = ""
  @State var email: String = ""
  @State var phoneNumber: String = ""
  @State var showInApp: Bool = false
  
  @State private var isShowPhotoLibrary = false
  @State private var image = UIImage()

  var body: some View {
      VStack {
        if showInApp {
            InAppView()
        } else {
            Text(/*@START_MENU_TOKEN@*/"ToolPool"/*@END_MENU_TOKEN@*/)
              .font(.largeTitle)
            Form {
              Section(header: Text("Log in information")) {
                TextField("Email", text: $email)
                TextField("Password", text: $password)
                TextField("Name", text: $username)
                TextField("Phone Number", text: $phoneNumber)
                Button(action: {
                                self.isShowPhotoLibrary = true
                            }) {
                                HStack {
                                    Image(systemName: "photo")
                                        .font(.system(size: 20))
                 
                                    Text("Photo library")
                                        .font(.headline)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                .padding(.horizontal)
                            }
                Image(uiImage: self.image)
                                .resizable()
                                .scaledToFill()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .edgesIgnoringSafeArea(.all)
              }
            }
          Button(action: {
            self.showInApp = true
            signUpAuth(em: email, pw: password, nm: username, ph: phoneNumber)
            loginAuth(un: email, pw: password)
            let filename = save(image: image, name: username)
            print(filename)
             // self.mode.wrappedValue.dismiss()
          }) { Text("Enter")
            .frame(minWidth:0, maxWidth:325)
            .background(Color.orange)
            .font(.title)
            .foregroundColor(.white)
            .cornerRadius(40)
          }
            
        }
      }.sheet(isPresented: $isShowPhotoLibrary) {
        ImagePicker(selectedImage: self.$image, sourceType: .photoLibrary)
    }
  }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}

func signUpAuth (em: String, pw: String, nm: String, ph: String) {
    var semaphore = DispatchSemaphore (value: 0)

    let parameters = [
      [
        "key": "email",
        "value": em,
        "type": "text"
      ],
      [
        "key": "password",
        "value": pw,
        "type": "text"
      ],
      [
        "key": "name",
        "value": nm,
        "type": "text"
      ],
      [
        "key": "phoneNumber",
        "value": ph,
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

    var request = URLRequest(url: URL(string: "http://0.0.0.0:8000/signup")!,timeoutInterval: Double.infinity)
    request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

    request.httpMethod = "POST"
    request.httpBody = postData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        return
      }
      print(String(data: data, encoding: .utf8)!)
      semaphore.signal()
    }

    task.resume()
    semaphore.wait()

}

