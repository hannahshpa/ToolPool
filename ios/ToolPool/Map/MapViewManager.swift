//
//  MapViewManager.swift
//  ToolPool
//
//  Created by Giovanni Moya on 11/19/20.
//

import Foundation
import SwiftUI
import MapKit

struct MapViewManager: View {
    
    @ObservedObject var locationManager = LocationManager()
    @State private var tools: [Tool] = [Tool]()
    @State private var search: String = ""
    
  
//    TODO: calling location data from database
//    private func load() {
//     Network.shared.apollo.fetch(query: ToolAnnotation(id: 1)) { result in
//       switch result {
//       case .success(let graphQLResult):
//         print("Success! Result: \(graphQLResult)")
//         if let tool_temp = graphQLResult.data?.tool {
//            self.tools = [Tool(tool_temp.name, tool_temp.name, tool_temp.location)]
//         }
//       case .failure(let error):
//         print("Failure! Error: \(error)")
//       }
//     }
//    }
    
    private func getNearByTools() {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        
        //look up local places, TODO: chagne this to look up locatiosn in database
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
//          TODO: remove search option because going to pull tool location data from DB
//            TextField("Search For Tool", text: $search, onEditingChanged: {
//                        _ in })
//            {
//                self.getNearByTools()
//            }.textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//                    .offset(y: 44)
        }
    }
}

