//
//  ProfileView.swift
//  ToolPool
//
//  CS 130 Group 8
//

import SwiftUI

struct ProfileView: View {
    let columns = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
    ]
  
    let numbers1 = [Int](repeating: 0, count: 100)
  
    var body: some View {
      NavigationView{
        GeometryReader {
            geometry in
          VStack {
            HStack {
              Image("profile")
                  .resizable()
                  .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.3)
                  .aspectRatio(contentMode: .fit)
              Text("Joe's ToolBox")
                .font(.largeTitle)
                .onAppear() {
                  do {
                      try returnToken()
                      print("token worked!")
                  } catch {
                      print("You can't use that password.")
                  }
                }
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
              
          }//.padding()
        }
        .navigationBarTitle(Text("Your toolbox"), displayMode: .inline)
        .navigationBarHidden(false)
        //.navigationBarTitle("Your ToolBox", displayMode: .inline)
        //.labelsHidden()
        //.navigationBarItems(trailing:
        //                      NavigationLink(destination: AddToolView()) {
        //                        Text("Add Tool")
        //                      }
        //)
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
      Group {
        ProfileView()
        ProfileView()
      }
    }
}

