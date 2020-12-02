//
//  ManageOtherUpcomingResPage.swift
//  ToolPool
//
//  Created by Alissa McNerney on 11/26/20.
//

import SwiftUI

struct ManageOtherUpcomingResPage: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    let borrow: GetOtherBorrowsQuery.Data.Self.OwnedTool.BorrowHistory!
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
                Text("User: " + borrow.user.name)
                Text("Email: \( borrow.user.email)")
                Text("Phone Number: \(borrow.user.phoneNumber)")
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

struct ManageOtherUpcomingResPage_Previews: PreviewProvider {
    static var previews: some View {
        ManageOtherUpcomingResPage(borrow: nil)
    }
}
