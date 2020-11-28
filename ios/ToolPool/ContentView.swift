//
//  ContentView.swift
//  ToolPool
//
//  CS 130 Group 8
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    var body: some View {

        TabView {
//            SearchView()
//                .tabItem {
//                    Image(systemName: "magnifyingglass")
//                    Text("Search")
//                }
//            RentalView()
//                .tabItem {
//                    Image(systemName: "wrench") // or toolbox "briefcase"
//                    Text("Rentals")
//                }
//
//            ProfileView()
//                .tabItem {
//                    Image(systemName: "person")
//                    Text("Profile")
//                }
            MapViewManager()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
            Landing()
                .tabItem {
                    Image(systemName: "person")
                    Text("profile")
                }
            
        }

//        Landing()

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
