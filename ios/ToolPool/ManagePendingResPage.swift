//
//  ManageReservationPage.swift
//  ToolPool
//
//  Created by Alissa McNerney on 11/12/20.
//
import SwiftUI

struct ManagePendingResPage: View {
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
            NavigationLink(destination: RentalView()) {
                Text("Accept Rental")
            } //simultaneously mutate rental obj to approve/deny?
            NavigationLink(destination: RentalView()) {
                Text("Deny Rental")
            }
          }
        }
      }
    }
}

struct ManagePendingResPage_Previews: PreviewProvider {
    static var previews: some View {
        ManagePendingResPage(toolName:"Sample Tool")
    }
}
