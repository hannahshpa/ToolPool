//
//  InAppView.swift
//  ToolPool
//
//  Created by Olsen on 11/4/20.
//

import SwiftUI

struct InAppView: View {
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
