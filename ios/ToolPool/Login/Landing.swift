//
//  Landing.swift
//  ToolPool
//
//  Created by Olsen on 11/4/20.
//

import SwiftUI

struct Landing: View {
    var body: some View {
      NavigationView {
        VStack {
          Text(/*@START_MENU_TOKEN@*/"ToolPool"/*@END_MENU_TOKEN@*/)
            .font(.largeTitle)
          NavigationLink(destination: SignInView()) {
            Text("Sign In")
              .foregroundColor(Color.black)
              .lineLimit(nil)
              .frame(width: 200.0)
              .background(Color.white)
              .padding()
              .border(Color.black, width:2)
          }.isDetailLink(false)
          NavigationLink(destination: CreateAccountView()) {
            Text("Create Account")
              .foregroundColor(Color.black)
              .lineLimit(nil)
              .frame(width: 200.0)
              .background(Color.white)
              .padding()
              .border(Color.black, width:2)
          }.isDetailLink(false)
        }
      }
      .navigationBarTitle("Navigation")
    }
}

struct Landing_Previews: PreviewProvider {
    static var previews: some View {
      Landing()
        .padding(.bottom, 100.0)
        
    }
}
