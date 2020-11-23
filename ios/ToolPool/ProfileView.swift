//
//  ProfileView.swift
//  ToolPool
//
//  CS 130 Group 8
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var selfData = mySelf()
    let columns = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
    ]
  
    let numbers1 = [Int](repeating: 0, count: 100)
  
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
            ScrollView {
                VStack {
                    MyToolCategoryRow(geometry: geometry, toolNameLeft: "tool", toolNameMiddle: "tool", toolNameRight: "tool")
                      MyToolCategoryRow(geometry: geometry, toolNameLeft: "tool", toolNameMiddle: "tool", toolNameRight: "tool")
                      MyToolCategoryRow(geometry: geometry, toolNameLeft: "tool", toolNameMiddle: "tool", toolNameRight: "tool")
                      MyToolCategoryRow(geometry: geometry, toolNameLeft: "tool", toolNameMiddle: "tool", toolNameRight: "tool")
                      MyToolCategoryRow(geometry: geometry, toolNameLeft: "tool", toolNameMiddle: "tool", toolNameRight: "tool")
                  }
              }
              
          }
        }
      }
}


struct MyToolCategoryRow: View {
    let geometry: GeometryProxy
    let toolNameLeft: String
    let toolNameMiddle: String
    let toolNameRight: String
    var body: some View {
        HStack { // position views horizontally
          NavigationLink(destination: ToolListingPage(listingName: toolNameLeft, categoryName: "tool")) {
                MyToolCategorySquare(geometry: geometry, categoryName: toolNameLeft)
            }
            NavigationLink(destination: ToolListingPage(listingName: toolNameMiddle, categoryName: "tool")) {
                MyToolCategorySquare(geometry: geometry, categoryName: toolNameMiddle)
            }
            NavigationLink(destination: ToolListingPage(listingName: toolNameRight, categoryName: "tool")) {
                MyToolCategorySquare(geometry: geometry, categoryName: toolNameRight)
            }
        }
    }
}

struct MyToolCategorySquare: View {
    let geometry: GeometryProxy
    let categoryName: String
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(categoryName.lowercased())
                .resizable()
                .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.3)
                .aspectRatio(contentMode: .fit)
            Text(categoryName).bold()
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
  var ownedTools: [Any] = []
  
  init(n: String, e: String, i: Int, ot: [Any]) {
    self.name = n
    self.email = e
    self.id = i
    self.ownedTools = ot
  }
}

class mySelf: ObservableObject {

    @Published var data: selfObj

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
            self.data = selfObj(n: self_temp.name, e: self_temp.email, i: self_temp.id, ot: self_temp.ownedTools)
            print(self_temp.name)
            print(self_temp.email)
            print(self_temp.ownedTools)
          }
       case .failure(let error):
         print("Failure! Error: \(error)")
       }
     }
    }
  
}
