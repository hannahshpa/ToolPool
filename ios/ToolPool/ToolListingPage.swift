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
    let categoryName:String
    @State private var date = Date()
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(listingName.lowercased())
                        .resizable()
                        .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                    Text(listingName)
                        .font(.title)
                        .foregroundColor(.black)
                    StarRatingView(rating: .constant(Int(4)))
                            .font(.largeTitle)
                            .padding(2)
                    Text("Category: " + categoryName)
                    Text("Price per hour: $5")
                    Text("Distance: 0.3 mi")
                    Text("Condition: Good")
                    Text("Owner: Owner Name")
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
        ToolListingPage(listingName:"Sample Tool", listingId: 0, categoryName: "Tool Category")
    }
}
