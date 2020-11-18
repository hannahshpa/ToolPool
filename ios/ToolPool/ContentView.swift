//
//  ContentView.swift
//  ToolPool
//
//  CS 130 Group 8
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @ObservedObject var locationManager = LocationManager()
    @State private var tools: [Tool] = [Tool]()
    @State private var search: String = ""
    
    private func getNearByTools() {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                //array of mkitems
                let mapItems = response.mapItems
                self.tools = mapItems.map {
                    Tool(placemark: $0.placemark)
                }
            }
        }
    }

    var body: some View {
        ZStack(alignment: .top) {
            
            MapView(tools: tools)
            
            TextField("Search For Tool", text: $search, onEditingChanged: {
                        _ in })
            {
                self.getNearByTools()
            }.textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .offset(y: 44)
        }
    }
//    var body: some View {
//        TabView {
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
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
