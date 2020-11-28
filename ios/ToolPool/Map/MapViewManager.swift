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
    @State private var tools: [ToolModel] = [ToolModel]()
    @State private var search: String = ""
    
  
// instiantiaing ToolModel annotation from database
private func loadTools() { Network.shared.apollo.fetch(query: ToolByIdQuery(id: 1)) { result in
       switch result {
       case .success(let graphQLResult):
         print("Success! Result: \(graphQLResult)")
//        let coordinate = CLLocationCoordinate2D(result)
//        print("graphqlresult", graphQLResult)
         if let tool_temp = graphQLResult.data?.tool {
            self.tools = [ToolModel(name: tool_temp.name, title: tool_temp.name,
//    self.tools = [ToolModel(name: "wrench", title: "wrench",
        coordinate: CLLocationCoordinate2D(latitude: tool_temp.location.lat, longitude: tool_temp.location.lon))]
//        coordinate: CLLocationCoordinate2D(latitude: 47.514980, longitude: -122.4194))]
        print("printing new tool", self.$tools[0].coordinate)
     }
   case .failure(let error):
     print("Failure! Error: \(error)")
   }
 }
}

    var body: some View {
        ZStack(alignment: .top) {
            MapView(tools: tools).onAppear {
                self.loadTools()
            }
        }
    }
}

