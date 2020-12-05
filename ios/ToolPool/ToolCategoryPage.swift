//
//  ToolCategoryPage.swift
//  ToolPool
//
//  Created by Hannah Park on 11/8/20.
//

import SwiftUI

struct ToolCategoryPage: View {
    let categoryName: String
    var body: some View {
            GeometryReader {
                geometry in
                ScrollView {
                    VStack {
                        ToolListingRow(geometry: geometry, listingNameLeft: "Hammer", listingNameRight: "Wrench", categoryName: categoryName)
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

struct ToolListingSquare: View {
    let geometry: GeometryProxy
    let listingName: String

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(listingName.lowercased())
                .resizable()
                .frame(width: geometry.size.width * 0.45, height: geometry.size.width * 0.45)
                .aspectRatio(contentMode: .fit)
            VStack {
                Text(listingName).bold()
                    .padding(1)
                    .font(.headline)
                    .foregroundColor(Color.white)
                StarRatingView(rating: .constant(Int(4)))
                    .font(.headline)
                }.padding(12)
        }
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous)) // Add clip shape to the whole ZStack
    }
}

struct ToolCategoryPage_Previews: PreviewProvider {
    static var previews: some View {
        ToolCategoryPage(categoryName:"Preview")
    }
}
