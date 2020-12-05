//
//  Landing.swift
//  ToolPool
//
//  Created by Olsen on 11/4/20.
//

import SwiftUI



struct Landing: View {
 
    //@ObservedObject var toolData = ToolData()
  
    var body: some View {
      NavigationView {
        VStack {
          Text(/*@START_MENU_TOKEN@*/"ToolPool"/*@END_MENU_TOKEN@*/)
            .font(.largeTitle)
            //.onAppear {
            //  self.greet()
            //}
          //Text(toolData.data.name)
          //Text(toolData.data.description)
          NavigationLink(destination: SignInView()) {
            Text("Sign In")
              .lineLimit(nil)
                .frame(width: 260.0, height: 60)
                .background(Color.orange)
                  .cornerRadius(40)
              .foregroundColor(.white)
                .padding()
                  .font(.title)
          }.isDetailLink(false)
          NavigationLink(destination: CreateAccountView()) {
            Text("Create Account")
              .lineLimit(nil)
              .frame(width: 260.0, height: 60)
              .background(Color.gray)
                .cornerRadius(40)
            .foregroundColor(.white)
              .padding()
                .font(.title)
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

class TestTool {
    var name: String = ""
    var description: String = ""
  
  init(n: String, d: String) {
    self.name = n
    self.description = d
  }
}

/*
class ToolData: ObservableObject {

    @Published var data: TestTool

    init() {
      self.data = TestTool(n: "test", d: "test")
      self.load()
    }
  
    func load() {
     Network.shared.apollo.fetch(query: ToolByIdQuery(id: 1)) { result in
       switch result {
       case .success(let graphQLResult):
         print("Success! Result: \(graphQLResult)")
         if let tool_temp = graphQLResult.data?.tool {
           self.data = TestTool(n: tool_temp.name, d: tool_temp.description)
         }
       case .failure(let error):
         print("Failure! Error: \(error)")
       }
     }
    }
  
}
*/
