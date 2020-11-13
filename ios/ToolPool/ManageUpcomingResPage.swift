//
//  ManageUpcomingResPage.swift
//  ToolPool
//
//  Created by Alissa McNerney on 11/12/20.
//

import SwiftUI

struct ManageUpcomingResPage: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
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
            Text("Date/Time:")
            Text("Duration:")
            Text("User:")
            Text("Cost:")
            Text("Location:")
            NavigationLink(destination: RateRental(toolName: "tool1")) {
                Text("Complete Rental")
            } //use simultaneous gesture to add time complete to rental obj & get rating
          }
        }
      }
    }
}

struct ManageUpcomingResPage_Previews: PreviewProvider {
    static var previews: some View {
        ManageUpcomingResPage(toolName:"Sample Tool")
    }
}
