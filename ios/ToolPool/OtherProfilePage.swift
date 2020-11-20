//
//  OtherProfilePage.swift
//  ToolPool
//
//  Created by Alissa McNerney on 11/19/20.
//

import SwiftUI

struct OtherProfilePage: View {
    let user: BorrowByIdQuery.Data.Borrow.User!
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
                Text(user.name + "'s ToolBox")
                .font(.largeTitle)
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
              //.padding()
          }
        }
      }
    }
}

struct OtherProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        OtherProfilePage(user: nil)
    }
}
