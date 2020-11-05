//
//  SignInView.swift
//  ToolPool
//
//  Created by Olsen on 11/4/20.
//

import SwiftUI

struct SignInView: View {
    @State var username: String = ""
    @State var password: String = ""
  
    var body: some View {
        VStack {
          Text(/*@START_MENU_TOKEN@*/"ToolPool"/*@END_MENU_TOKEN@*/)
            .font(.largeTitle)
          Form {
            Section(header: Text("Log in info")) {
              TextField("Username", text: $username)
              TextField("Password", text: $password)
            }
          }
          NavigationLink(destination: InAppView()) {
            Text("Enter")
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

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
