//
//  ManageUpcomingResPage.swift
//  ToolPool
//
//  Created by Alissa McNerney on 11/12/20.
//

import SwiftUI

struct ManageUpcomingResPage: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    let borrow: GetBorrowsQuery.Data.Self.BorrowHistory!
    var body: some View {
      ScrollView {
        GeometryReader {
            geometry in
          VStack {
            Image("tool")
                .resizable()
                .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                .aspectRatio(contentMode: .fit)
            Text(borrow.tool.name)
                .font(.title)
                .foregroundColor(.black)
            Divider()
            Group {
                Text("Start: \(NSDate(timeIntervalSinceReferenceDate: TimeInterval(borrow.loanPeriod.start)!) )")
                Text("End: \(NSDate(timeIntervalSinceReferenceDate: TimeInterval(borrow.loanPeriod.end)!) )")
                Text("Cost: \(borrow.cost)")
                Text("Location: (insert map)")
                Text("Owner: " + borrow.tool.owner.name)
                Text("Email: \( borrow.tool.owner.email)")
                Text("Phone Number: \(borrow.tool.owner.phoneNumber)")
            }
            Divider()
            NavigationLink(destination: RateRental(toolName: "tool1")) {
                Text("Complete Rental")
                    .frame(minWidth:0, maxWidth:325)
                    .background(Color.orange)
                    .font(.title)
                    .foregroundColor(.white)
                    .cornerRadius(40)
            }
          }
        }
      }
      .navigationBarTitle(Text("Upcoming Rental"), displayMode: .inline)
    }
}

struct ManageUpcomingResPage_Previews: PreviewProvider {
    static var previews: some View {
        ManageUpcomingResPage(borrow: nil)
    }
}
