//
//  ToolCategoryPage.swift
//  ToolPool
//
//  Created by Hannah Park on 11/8/20.
//

import SwiftUI

struct ToolCategoryPage: View {
    let categoryName: String

    @ObservedObject var myCategoryTools: categoryTools = categoryTools()
    
    init(_ name: String) {
        self.categoryName = name
      self.myCategoryTools.load(c:GeoLocationInput(lat:32,lon:32), r:50.0)
    }
    
    var body: some View {
            GeometryReader {
                geometry in
                /*
                ScrollView {
                    VStack {
                        ToolListingRow(geometry: geometry, listingNameLeft: "Hammer", listingNameRight: "Wrench", categoryName: categoryName)
                        
                        ForEach(myCategoryTools.data.tools, id: \.id) { t in
                            ToolListingRow(geometry: geometry, listingNameLeft: t.name, listingNameRight: "Wrench", categoryName: categoryName)
                            
                        }
                    }
                }*/
                ScrollView(.vertical) {
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), alignment: .center) {
                      
                      ForEach(myCategoryTools.data.tools, id: \.id) { t in
                        NavigationLink(destination: ToolListingPage(t.name, id: t.id, category:categoryName)) {
                            ToolListingSquare(geometry: geometry, listingName: t.name)
                        }
                      }
                    }
                }
                //.onAppear(perform: myCategoryTools.load(c:GeoLocationInput(lat:32,lon:32), r:50.0))
                .padding()
            }
            //.onAppear(perform: myCategoryTools.load(c:GeoLocationInput(lat:32,lon:32), r:50.0))
            .navigationBarTitle(categoryName, displayMode: .inline)
            .navigationBarItems(trailing:
                                  NavigationLink(destination: FilterView()) {
                                    Text("Filter")
                                  }
            )
        }
    
}
/*
struct ToolListingRow: View {
    let geometry: GeometryProxy
    let listingNameLeft: String
    let listingNameRight: String
    let categoryName: String
    var body: some View {
        HStack { // position views horizontally
            NavigationLink(destination: ToolListingPage(listingName:listingNameLeft, categoryName:categoryName)) {
                ToolListingSquare(geometry: geometry, listingName: listingNameLeft)
            }
            NavigationLink(destination: ToolListingPage(listingName:listingNameRight, categoryName:categoryName)) {
                ToolListingSquare(geometry: geometry, listingName: listingNameRight)
            }
        }
    }
}
*/
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

class toolsObj {
    var tools: [GetNearbyQuery.Data.Nearby] = []
  
  init(t: [GetNearbyQuery.Data.Nearby]) {
    self.tools = t
  }
}

class categoryTools: ObservableObject {

  @Published var data: toolsObj {
    willSet {
        objectWillChange.send()
    }
  }
    
    init() {
      self.data = toolsObj(t: [])
        self.load(c:GeoLocationInput(lat:32,lon:32), r:50.0)
    }
  
    func load(c:GeoLocationInput, r:Double) {
        Network.shared.apollo.fetch(query: GetNearbyQuery(center:c, radius:r)) { result in
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
