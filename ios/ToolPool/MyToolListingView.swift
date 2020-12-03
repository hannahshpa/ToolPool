//
//  MyToolListingView.swift
//  ToolPool
//
//  Created by Olsen on 11/24/20.
//


import SwiftUI
import Combine

struct MyToolListingView: View {

  let toolId: Int
  @ObservedObject var displayTool = myTool()

  
  init(_ id: Int) {
    self.toolId = id
    self.displayTool.load(tool_id: toolId) {}
  }
  
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                  NavigationLink(destination: InAppView()) {
                      Text("Back To My Toolbox")
                          .frame(minWidth:0, maxWidth:325)
                          .background(Color.orange)
                          .font(.title)
                          .foregroundColor(.white)
                          .cornerRadius(40)
                  }
                  if (loadImage(fileName: String(toolId)) != nil) {
                    Image(uiImage: loadImage(fileName: String(toolId))!)
                      .resizable()
                      .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                      .aspectRatio(contentMode: .fit)
                  } else {
                    Image("tool")
                      .resizable()
                      .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                      .aspectRatio(contentMode: .fit)
                  }
                  Text(displayTool.data!.name)
                        .font(.title)
                        .foregroundColor(.black)
                  //StarRatingView(rating: .constant(Int(4)))
                  //          .font(.largeTitle)
                  //          .padding(2)
                  Text("Description: " + displayTool.data!.description)
                  Text("Cost per hour: $" + String(displayTool.data!.hourlyCost))
                  Text("Category: " + String(displayTool.data!.tags[0]))
                  //Text("Location: 0.3 mi")
                  //Text("Condition: " + displayTool.data!.condition.rawValue)

                }
                Spacer()
            }
        }
        .navigationBarTitle(Text("Tool Details"), displayMode: .inline)
        .navigationBarHidden(true)
    }
}

class toolObj {
  var name: String = ""
  var description: String = ""
  var hourly_cost: Double = 0
  var condition: String = ""
  
  init(n: String, d: String, h: Double, c: String) {
    self.name = n
    self.description = d
    self.hourly_cost = h
    self.condition = c
  }
}



class myTool: ObservableObject {

  @Published var data: ToolByIdQuery.Data.Tool?
    
  init(id: Int) {
    self.data = nil
    self.load(tool_id: id) {}
  }
  
  init() {
    self.data = nil
  }
  
  func load(tool_id: Int, completed:  @escaping () -> ()) {
      Network.shared.apollo.fetch(query: ToolByIdQuery(id: tool_id)) { result in
       switch result {
       case .success(let graphQLResult):
          print("Success! Result: \(graphQLResult)")
        if let tool_temp = graphQLResult.data?.tool {
            self.objectWillChange.send()
            self.data = tool_temp
          }
        completed()
       case .failure(let error):
         print("Failure! Error: \(error)")
         completed()
       }
     }
    }
  
}


