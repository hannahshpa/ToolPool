//
//  RentalTabs.swift
//  ToolPool
//
//  Created by Alissa McNerney on 11/20/20.
//

import Foundation
import SwiftUI
import CoreData

struct InAppView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Tool.entity(), sortDescriptors: []) var tools: FetchedResults<Tool>

    @State private var showingAddScreen = false
   var body: some View {
    TabView {
        SearchView()
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        RentalView()
            .tabItem {
                Image(systemName: "wrench") // or toolbox "briefcase"
                Text("Rentals")
            }
        ProfileView()
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
    }
    .navigationBarBackButtonHidden(true)
  }
}

struct InAppView_Previews: PreviewProvider {
    static var previews: some View {
        InAppView()
    }
}

struct TabbedView: View {

    @State private var selectedTab: Int = 0

    var body: some View {
        HStack {
            SegmentedControl(selection: $selectedTab) {
                Text("My Rentals").tag(0)
                Text("Other's Rentals").tag(1)
            }

            switch(selectedTab) {
                case 0:RentalView()
                case 1: RentalView()
            }
        }
    }
}
