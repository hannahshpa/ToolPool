//
//  SearchView.swift
//  ToolPool
//
//  CS 130 Group 8
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        NavigationView {
            GeometryReader {
                geometry in
                ScrollView {
                    VStack {
                        ToolCategoryRow(geometry: geometry, categoryNameLeft: "Camping", categoryNameRight: "Cleaning")
                        ToolCategoryRow(geometry: geometry, categoryNameLeft: "Gardening", categoryNameRight: "Hand Tools")
                        ToolCategoryRow(geometry: geometry, categoryNameLeft: "Kitchen", categoryNameRight: "Outdoor")
                        ToolCategoryRow(geometry: geometry, categoryNameLeft: "Painting", categoryNameRight: "Power Tools")
                        ToolCategoryRow(geometry: geometry, categoryNameLeft: "Safety", categoryNameRight: "Miscellaneous")
                    }
                }
                .padding()
            }
            .navigationBarTitle("Find Tools", displayMode: .automatic)
        }
    }
}

struct ToolCategoryRow: View {
    let geometry: GeometryProxy
    let categoryNameLeft: String
    let categoryNameRight: String
    var body: some View {
        HStack { // position views horizontally
            NavigationLink(destination: ToolCategoryPage(categoryName:categoryNameLeft)) {
                ToolCategorySquare(geometry: geometry, categoryName: categoryNameLeft)
            }
            NavigationLink(destination: ToolCategoryPage(categoryName:categoryNameRight)) {
                ToolCategorySquare(geometry: geometry, categoryName: categoryNameRight)
            }
        }
    }
}

struct ToolCategorySquare: View {
    let geometry: GeometryProxy
    let categoryName: String
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(categoryName.lowercased())
                .resizable()
                .frame(width: geometry.size.width * 0.45, height: geometry.size.width * 0.45)
                .aspectRatio(contentMode: .fit)
            Text(categoryName).bold()
                .padding(12)
                .font(.headline)
                .foregroundColor(Color.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous)) // Add clip shape to the whole ZStack
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
