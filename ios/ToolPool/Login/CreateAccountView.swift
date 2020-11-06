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
  @State var city: String = ""
  @State var state: String = ""

  var body: some View {
      VStack {
        Text(/*@START_MENU_TOKEN@*/"ToolPool"/*@END_MENU_TOKEN@*/)
          .font(.largeTitle)
        Form {
          Section(header: Text("Log in information")) {
            TextField("Username", text: $username)
            TextField("Password", text: $password)
            TextField("Email", text: $email)
          }
          Section(header: Text("Location information")) {
            TextField("City", text: $city)
            TextField("State", text: $state)
          }
        }
        NavigationLink(destination: InAppView()) {
          Text("Create New Account")
            .foregroundColor(Color.black)
            .lineLimit(nil)
            .frame(width: 200.0)
            .background(Color.white)
            .padding()
            .border(Color.black, width:2)
        }.isDetailLink(false)
      }
  }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
