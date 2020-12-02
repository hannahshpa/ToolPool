//
//  InAppView.swift
//  ToolPool
//
//  Created by Olsen on 11/4/20.
//

import SwiftUI
import CoreData

struct InAppView: View {
    @Environment(\.managedObjectContext) var moc
    //@FetchRequest(entity: Tool.entity(), sortDescriptors: []) var tools: FetchedResults<Tool>
    //let tabId: Int
    @State private var selection = 1
  
    @State private var showingAddScreen = false
   var body: some View {
    TabView(selection: $selection) {
        SearchView()
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
          .tag(0)
        RentalView()
            .tabItem {
                Image(systemName: "briefcase") // or toolbox "briefcase"
                Text("My Rentals")
            }
        OtherRentalView()
            .tabItem {
                Image(systemName: "wrench") // or toolbox "briefcase"
                Text("Others' Rentals")
            }
        ProfileView()
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
          .tag(1)
    }
    .navigationBarBackButtonHidden(true)
  }
}

struct InAppView_Previews: PreviewProvider {
    static var previews: some View {
        InAppView()
    }
}
