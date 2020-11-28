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
                .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                .aspectRatio(contentMode: .fit)
            Text(borrow.tool.name)
                .font(.title)
                .foregroundColor(.black)
            Divider()
            Group {
                Text("Date/Time: " + borrow.loanPeriod.start)
                Text("Duration: " + borrow.loanPeriod.end)
                Text("Cost: \(borrow.cost)")
                Text("Location: (insert map)")
                NavigationLink(destination:OtherProfilePage(user: borrow.user)) {
                    Text("User: " + borrow.user.name)
                }
            }
            Divider()
            Button(action: {
                self.mode.wrappedValue.dismiss()
            }) { Text("Accept Rental")
                .frame(minWidth:0, maxWidth:325)
                .background(Color.orange)
                .font(.title)
                .foregroundColor(.white)
                .cornerRadius(40)
            }//simultaneously mutate rental obj to approve/deny?
            Text(" ")
            Button(action: {
                self.mode.wrappedValue.dismiss()
            }) { Text("Deny Rental")
                .frame(minWidth:0, maxWidth:325)
                .background(Color.gray)
                .font(.title)
                .foregroundColor(.white)
                .cornerRadius(40)
            }
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
