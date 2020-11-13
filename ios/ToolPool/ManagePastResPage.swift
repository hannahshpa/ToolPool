//
//  ManagePastRePage.swift
//  ToolPool
//
//  Created by Alissa McNerney on 11/12/20.
//

import SwiftUI

struct ManagePastResPage: View {
    let toolName: String
    var body: some View {
      ScrollView {
        GeometryReader {
            geometry in
          VStack {
            Image("tool")
                .resizable()
                .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.3)
                .aspectRatio(contentMode: .fit)
            Text(toolName).font(.largeTitle)
            Divider()
            Text("Date:")
            Text("User:")
            Text("Cost:")
            Text("Location:")
            Text("Rental Rating:")
            NavigationLink(destination: ToolListingPage(listingName: toolName)) {
                Text("Rent Again")
            }
          }
        }
      }
    }
}

struct ManagePastResPage_Previews: PreviewProvider {
    static var previews: some View {
        ManagePastResPage(toolName:"Sample Tool")
    }
}
