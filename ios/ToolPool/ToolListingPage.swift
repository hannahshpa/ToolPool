//
//  ToolListingPage.swift
//  ToolPool
//
//  Created by Hannah Park on 11/11/20.
//

import SwiftUI

struct ToolListingPage: View {
    let listingName: String
    var body: some View {
      ScrollView {
        GeometryReader {
            geometry in
          VStack {
            Image("tool")
                .resizable()
                .frame(width: geometry.size.width * 0.6, height: geometry.size.width * 0.6)
                .aspectRatio(contentMode: .fit)
            Text(listingName).font(.largeTitle)
            Divider()
            Text("Price:")
            Text("Condition:")
            Text("Description:")
          }
        }
      }
    }
}

struct ToolListingPage_Previews: PreviewProvider {
    static var previews: some View {
        ToolListingPage(listingName:"Sample Tool")
    }
}
