//
//  ToolCategoryPage.swift
//  ToolPool
//
//  Created by Hannah Park on 11/8/20.
//

import SwiftUI
import MapKit

struct ToolCategoryPage: View {
    let categoryName: String

    @ObservedObject var myCategoryTools: categoryTools = categoryTools()
    @ObservedObject var locationManager = LocationManager()
    var userLocation = UserLocation()
    
    init(_ name: String) {
        
        self.categoryName = name
        let location = userLocation.getLocation()
        self.myCategoryTools.load(c:GeoLocationInput(lat: location.coordinate.latitude, lon: location.coordinate.longitude), r:50.0, cat: name)
    }
        
    var body: some View {
            GeometryReader {
                geometry in
                
                ScrollView(.vertical) {
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), alignment: .center) {
                      
                      ForEach(myCategoryTools.data.tools, id: \.id) { t in
                        NavigationLink(destination: ToolListingPage(t.name, id: t.id, category:categoryName)) {
                            ToolListingSquare(geometry: geometry, listingName: t.name)
                        }
                      }
                    }
                }

                .padding()
            }

            .navigationBarTitle(categoryName, displayMode: .inline)
            .navigationBarItems(trailing:
                                  NavigationLink(destination: FilterView()) {
                                    Text("Filter")
                                  }
            )
        }
    
}


struct ToolListingSquare: View {
    let geometry: GeometryProxy
    let listingName: String

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image("tool")   // hard coded right now, but can do listingName.lowercased() if it's one of the hard coded ones like hammer
                .resizable()
                .frame(width: geometry.size.width * 0.45, height: geometry.size.width * 0.45)
                .aspectRatio(contentMode: .fit)
            VStack {
                Text(listingName).bold()
                    .padding(1)
                    .font(.headline)
                    .foregroundColor(Color.white)
                //StarRatingView(rating: .constant(Int(displayTool.data!.averageRating)))
                StarRatingView(rating: .constant(Int(4)))   // hard coded for now
                    .font(.headline)
                }.padding(12)
        }
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous)) // Add clip shape to the whole ZStack
    }
}

struct ToolCategoryPage_Previews: PreviewProvider {
    static var previews: some View {
        ToolCategoryPage("Preview")
    }
}

//class to get user location from locationManager
class UserLocation {
    @ObservedObject var locationManager = LocationManager()
    var lat: String
    var lon: String
    init() {
        lat = "32.0"
        lon = "-132.0"
    }

    // this is a completion to ensure latitude and longitude is initialized! :)
    func getLocation() -> CLLocation {
        locationManager.getUserLocation { (lat, lng) in
        self.lat = lat
        self.lon = lng
        debugPrint("Latitude:", lat)
        debugPrint("Longitude:", lng)

        }
        return CLLocation(latitude: Double(self.lat) ?? 32.0, longitude: Double(self.lon) ?? -132.0)
    }
}

class toolsObj {
    var tools: [GetNearbyQuery.Data.Nearby] = []
  
  init(t: [GetNearbyQuery.Data.Nearby]) {
    self.tools = t
  }
}

class categoryTools: ObservableObject {
    @ObservedObject var locationManager = LocationManager()
    var userLocation = UserLocation()
  @Published var data: toolsObj {
    willSet {
        objectWillChange.send()
    }
  }


    init() {

        self.data = toolsObj(t: [])
//        self.load(c:GeoLocationInput(lat:32,lon:32), r:50.0)
        //let location = userLocation.getLocation()
        //self.load(c:GeoLocationInput(lat: location.coordinate.latitude, lon: location.coordinate.longitude), r:50.0)
    }
  
    func load(c:GeoLocationInput, r:Double, cat:String) {
        Network.shared.apollo.fetch(query: GetNearbyQuery(center:c, radius:r, category: cat)) { result in
       switch result {
       case .success(let graphQLResult):
          print("Success! Result: \(graphQLResult)")
          if let self_temp = graphQLResult.data?.`nearby` {
            self.objectWillChange.send()
            self.data = toolsObj(t: self_temp)
            print("updated-----------------")
            
          }
       case .failure(let error):
         print("Failure! Error: \(error)")
       }
     }
    }
  
}
