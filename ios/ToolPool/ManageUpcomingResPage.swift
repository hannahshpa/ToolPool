//
//  ManageUpcomingResPage.swift
//  ToolPool
//
//  Created by Alissa McNerney on 11/12/20.
//

import SwiftUI

struct ManageUpcomingResPage: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    let borrow: BorrowByIdQuery.Data.Borrow!
    var body: some View {
      ScrollView {
        GeometryReader {
            geometry in
          VStack {
            Image("tool")
                .resizable()
                .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.3)
                .aspectRatio(contentMode: .fit)
            Text(borrow.tool.name).font(.largeTitle)
            Divider()
            Text("Date/Time: " + borrow.loanPeriod.start)
            Text("Duration: " + borrow.loanPeriod.end)
            Text("User: " + borrow.user.name)
            Text("Cost: \(borrow.cost)")
            Text("Location: (insert map)")
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
        ManageUpcomingResPage(borrow: nil)
    }
}
