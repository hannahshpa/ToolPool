//
//  ProfileView.swift
//  ToolPool
//
//  CS 130 Group 8
//

import SwiftUI

struct ProfileView: View {
  
  @ObservedObject var selfData: mySelf = mySelf()
  
  init() {
    self.selfData.load()
  }
  
    var body: some View {
      //NavigationView{
        GeometryReader {
            geometry in
          VStack {
            HStack {
              Image("profile")
                  .resizable()
                  .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.3)
                  .aspectRatio(contentMode: .fit)
              Text(selfData.data.name + "'s ToolBox")
                .font(.largeTitle)
                .onAppear() {
                  self.selfData.objectWillChange.send()
                }
            }
            Divider()
            NavigationLink(destination: AddToolView(ownerId: selfData.data.id)) {
                Text("Add New Tool")
                    .frame(minWidth:0, maxWidth:325)
                    .background(Color.orange)
                    .font(.title)
                    .foregroundColor(.white)
                    .cornerRadius(40)
            }
            Divider()
            //TestView(geometry: geometry, myTools: selfData.data.ownedTools)
            ScrollView(.vertical) {
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), alignment: .center) {
                  
                  ForEach(selfData.data.ownedTools, id: \.id) { t in
                    NavigationLink(destination: MyToolListingView(t.id)) {
                      MyToolCategorySquare(geometry: geometry, toolName: t.name, toolId: t.id)
                    }
                  }
                }
            }.onAppear(perform: selfData.load)
          }
        }.onAppear(perform: selfData.load)
      }
}


struct MyToolCategorySquare: View {
    let geometry: GeometryProxy
    let toolName: String
    let toolId: Int
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image("tool")
                .resizable()
                .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.3)
                .aspectRatio(contentMode: .fit)
            Text(toolName).bold()
                .padding(6)
                .font(.headline)
                .foregroundColor(Color.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous)) // Add clip shape to the whole ZStack
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


class selfObj {
  var name: String = ""
  var email: String = ""
  var id: Int = 0
  var ownedTools: [GetSelfQuery.Data.Self.OwnedTool] = []
  //var myTools = [GetSelfQuery.Data.Self.OwnedTool]()
  
  init(n: String, e: String, i: Int, ot: [GetSelfQuery.Data.Self.OwnedTool]) {
    self.name = n
    self.email = e
    self.id = i
    self.ownedTools = ot
  }
}

class mySelf: ObservableObject {

  @Published var data: selfObj {
    willSet {
        objectWillChange.send()
    }
  }
    
    init() {
      self.data = selfObj(n: "test", e: "test", i: 0, ot: [])
      self.load()
    }
  
    func load() {
     Network.shared.apollo.fetch(query: GetSelfQuery()) { result in
       switch result {
       case .success(let graphQLResult):
          print("Success! Result: \(graphQLResult)")
          if let self_temp = graphQLResult.data?.`self` {
            self.objectWillChange.send()
            self.data = selfObj(n: self_temp.name, e: self_temp.email, i: self_temp.id, ot: self_temp.ownedTools)
            print("updated-----------------")
            
          }
       case .failure(let error):
         print("Failure! Error: \(error)")
       }
     }
    }
  
}


/*
struct TestView: View {
    let geometry: GeometryProxy
    let myTools: [GetSelfQuery.Data.Self.OwnedTool]

    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), alignment: .center) {

              ForEach(myTools, id: \.id) { t in
                MyToolCategorySquare(geometry: geometry, toolName: t.name, toolId: t.id)
              }
            }
        }
    }
}*/
