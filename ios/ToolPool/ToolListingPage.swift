//
//  ToolListingPage.swift
//  ToolPool
//
//  Created by Hannah Park on 11/11/20.
//

import SwiftUI

struct ToolListingPage: View {
    let listingName: String
    let listingId: Int
    let categoryName: String
    @ObservedObject var displayTool = myListingTool()
    
    /*
     Type(Tool.self){
         Field("id", at:\.id)
         Field("condition", at: \.condition)
         Field("owner", at: Tool.getOwner)
         Field("name", at: \.name)
         Field("hourly_cost", at: \.hourlyCost)
         Field("description", at: \.description)
         Field("location", at: \.location)
         Field("borrowHistory", at: Tool.getBorrowHistory, as: [Borrow].self)
             .description("The history of this tool being loaned out")
         Field("images", at: Tool.getImages)
         Field("tags", at: Tool.getTags)
         Field("ratings", at: Tool.getRatings)
         Field("schedule", at: Tool.getSchedule)
         Field("averageRating", at: Tool.getAverageRating)
     */
    init(_ name: String, id: Int, category: String) {
        self.listingName = name
        self.listingId = id
        self.categoryName = category
        self.displayTool.load(tool_id:listingId)
    }
    @State private var date = Date()
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(listingName.lowercased()) // listingName.lowercased()
                        .resizable()
                        .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                    Text(listingName)
                        .font(.title)
                        .foregroundColor(.black)
                    //StarRatingView(rating: .constant(Int(displayTool.data!.averageRating)))
                    StarRatingView(rating: .constant(Int(4)))// hard coded for now to 4
                            .font(.largeTitle)
                            .padding(2)
                    Text("Category: " + categoryName)
                    Text("Cost per hour: $" + String(displayTool.data!.hourlyCost))
                    Text("Distance: 0.3 mi") // hard coded for now
                    Text("Condition: " + displayTool.data!.condition.rawValue.uppercased())
                    Text("Owner: " + displayTool.data!.owner.name)
                    DatePicker(
                          "Start Date",
                          selection: $date,
                            in: Date()...,
                          displayedComponents: [.date]
                      )
                        .datePickerStyle(GraphicalDatePickerStyle())
                    NavigationLink(destination: MakeReservationView(date:self.date)) {
                        Text("Set Reservation Details")
                            .frame(minWidth:0, maxWidth:325)
                            .background(Color.orange)
                            .font(.title)
                            .foregroundColor(.white)
                            .cornerRadius(40)
                    }
                }
                Spacer()
            }
        }
        .navigationBarTitle(Text("Tool Details"), displayMode: .inline)
    }
}

struct ToolListingPage_Previews: PreviewProvider {
    static var previews: some View {
        ToolListingPage("Sample Tool", id:0, category:"Tool Category")
    }
}

class toolObject {
  var name: String = ""
  var description: String = ""
  var hourly_cost: Double = 0
  var condition: String = ""
  
  init(n: String, d: String, h: Double, c: String) {
    self.name = n
    self.description = d
    self.hourly_cost = h
    self.condition = c
  }
}



class myListingTool: ObservableObject {

  @Published var data: ToolByIdQuery.Data.Tool?
    
  init(id: Int) {
    self.data = nil
    self.load(tool_id: id)
  }
  
  init() {
    self.data = nil
  }
  
  func load(tool_id: Int) {
      Network.shared.apollo.fetch(query: ToolByIdQuery(id: tool_id)) { result in
       switch result {
       case .success(let graphQLResult):
          print("Success! Result: \(graphQLResult)")
        if let tool_temp = graphQLResult.data?.tool {
            self.objectWillChange.send()
            self.data = tool_temp
          }
       case .failure(let error):
         print("Failure! Error: \(error)")
       }
     }
    }
  
}
