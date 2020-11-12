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
        NavigationView {
            GeometryReader {
                geometry in
                ScrollView {
                    VStack {
                        ToolListingRow(geometry: geometry, listingNameLeft: "Hammer", listingNameRight: "Wrench")
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
}

struct ToolListingRow: View {
    let geometry: GeometryProxy
    let listingNameLeft: String
    let listingNameRight: String
    var body: some View {
        HStack { // position views horizontally
            NavigationLink(destination: ToolListingPage(listingName:listingNameLeft)) {
                ToolListingSquare(geometry: geometry, listingName: listingNameLeft)
            }
            NavigationLink(destination: ToolListingPage(listingName:listingNameRight)) {
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
            Text(listingName).bold()
                .padding(12)
                .font(.headline)
                .foregroundColor(Color.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous)) // Add clip shape to the whole ZStack
    }
}

struct ToolCategoryPage_Previews: PreviewProvider {
    static var previews: some View {
        ToolCategoryPage(categoryName:"Preview")
    }
}
