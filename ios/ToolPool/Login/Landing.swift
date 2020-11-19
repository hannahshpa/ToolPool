//
//  Landing.swift
//  ToolPool
//
//  Created by Olsen on 11/4/20.
//

import SwiftUI



struct Landing: View {
  
    func greet() {
        Network.shared.apollo.fetch(query: ToolByIdQuery(id: 1)) { result in
            switch result {
            case .success(let graphQLResult):
              print("Success! Result: \(graphQLResult)")
            case .failure(let error):
              print("Failure! Error: \(error)")
            }
          }
        /*Network.shared.apollo.fetch(query: GetBorrowsQuery()) { result in //doesnt work bc self is null rn. need to create users?
          switch result {
          case .success(let graphQLResult):
            print("Success! Result: \(graphQLResult)")
          case .failure(let error):
            print("Failure! Error: \(error)")
          }
        }*/
      //var test = Network.shared.apollo.fetch(query: ToolByIdQuery())
      //test.
    }
  
    //let variable = greet()
  
    var body: some View {
      NavigationView {
        VStack {
          Text(/*@START_MENU_TOKEN@*/"ToolPool"/*@END_MENU_TOKEN@*/)
            .font(.largeTitle)
            .onAppear {
              self.greet()
            }
          
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
