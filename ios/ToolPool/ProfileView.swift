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
        VStack {
          HStack {
            Text("Image")
            Text("Welcome Joe")
              .font(.largeTitle)
          }
          LazyVGrid(columns: columns) /*@START_MENU_TOKEN@*/{
            
            Text("Tool1")
            Text("Tool2")
            Text("Tool3")
            Text("Tool4")
            Text("Tool5")
            Text("Tool6")
            RoundedRectangle(cornerRadius: 10, style: .continuous)
              .fill(Color.white)
              .frame(width: 100, height: 100)
              .border(Color.black, width: 2)
          }/*@END_MENU_TOKEN@*/
        }
        .navigationBarTitle("Your ToolBox", displayMode: .inline)
        .navigationBarItems(trailing:
                              NavigationLink(destination: AddToolView()) {
                                Text("Add Tool")
                              }
        )
      }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

