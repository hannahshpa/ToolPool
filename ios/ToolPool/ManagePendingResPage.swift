//
//  ManageReservationPage.swift
//  ToolPool
//
//  Created by Alissa McNerney on 11/12/20.
//
import SwiftUI

struct ManagePendingResPage: View {
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
            Button(action: {
                self.mode.wrappedValue.dismiss()
            }) { Text("Accept Rental")}//simultaneously mutate rental obj to approve/deny?
            Button(action: {
                self.mode.wrappedValue.dismiss()
            }) { Text("Deny Rental")}
          }
        }
      }
    }
}

struct ManagePendingResPage_Previews: PreviewProvider {
    static var previews: some View {
        ManagePendingResPage(borrow: nil)
    }
}
