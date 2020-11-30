//
//  ManageReservationPage.swift
//  ToolPool
//
//  Created by Alissa McNerney on 11/12/20.
//
import SwiftUI

struct ManagePendingResPage: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    let borrow: GetBorrowsQuery.Data.Self.BorrowHistory!
    var body: some View {
    GeometryReader {
        geometry in
        ScrollView {
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
                //Text("Date/Time: " + borrow.loanPeriod.start)
                //Text("Duration: " + borrow.loanPeriod.end)
                Text("Cost: \(borrow.cost)")
                Text("Location: (insert map)")
                Text("Owner: " + borrow.tool.owner.name)
                Text("Email: \( borrow.tool.owner.email)")
                Text("Phone Number: \(borrow.tool.owner.phoneNumber)")
                
            }
            Divider()
            Text("Awaiting Owner Approval")
                .font(.caption)
          }
        }
      }
      .navigationBarTitle(Text("Pending Rental"), displayMode: .inline)
    }
}

struct ManagePendingResPage_Previews: PreviewProvider {
    static var previews: some View {
        ManagePendingResPage(borrow: nil)
    }
}
