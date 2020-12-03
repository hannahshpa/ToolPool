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
    @State var imDoneUp: Bool = false
    var body: some View {
        if imDoneUp {
          OtherRentalView()
        } else {
        GeometryReader {
            geometry in
          ScrollView {
          VStack {
            if (loadImage(fileName: String(borrow.tool.id)) != nil) {
                Image(uiImage: loadImage(fileName: String(borrow.tool.id))!)
                .resizable()
                .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                .aspectRatio(contentMode: .fit)
            } else {
              Image("tool")
                .resizable()
                .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                .aspectRatio(contentMode: .fit)
            }
            Text(borrow.tool.name)
                .font(.title)
                .foregroundColor(.black)
            Divider()
            Group {
                Text("Start: \(NSDate(timeIntervalSinceReferenceDate: TimeInterval(borrow.loanPeriod.start)))")
                Text("End: \(NSDate(timeIntervalSinceReferenceDate: TimeInterval(borrow.loanPeriod.end)))")
                Text("Cost: " + String(format: "%.2f", borrow.cost))
//                Text("Location: (insert map)")
                Text("User: " + borrow.user.name)
                Text("Email: \( borrow.user.email)")
                Text("Phone Number: \(borrow.user.phoneNumber)")
            }
            NavigationLink(destination: MapViewManager(id: borrow.tool.id)) {
                Text("Get Directions To Tool")
                    .frame(minWidth:0, maxWidth:325)
                    .background(Color.orange)
                    .font(.title)
                    .foregroundColor(.white)
                    .cornerRadius(40)
            }
            Divider()
            if(borrow.timeReturned != nil) {
            NavigationLink(destination: RateUser(completed_borrow: borrow)) {
                Text("Complete Rental")
                    .frame(minWidth:0, maxWidth:325)
                    .background(Color.orange)
                    .font(.title)
                    .foregroundColor(.white)
                    .cornerRadius(40)
            }} else {
                Text("Awaiting Return by Rentee")
                    .font(.caption)
            }
            Divider()
            Button(action: {
                denyReturn(borrow_id: borrow.id){}
                self.imDoneUp = true
            }) { Text("Report Unreturned Tool")
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
}

struct ManageOtherUpcomingResPage_Previews: PreviewProvider {
    static var previews: some View {
        ManageOtherUpcomingResPage(borrow: nil)
    }
}

func denyReturn(borrow_id: Int, completed: @escaping () -> ()) {
    Network.shared.apollo.clearCache()
    Network.shared.apollo.perform(mutation: AcceptReturnMutation(borrowId: borrow_id, accept: false)) { result in
      switch result {
      case .success(let graphQLResult):
        print("Success! Result: \(graphQLResult)")
      case .failure(let error):
        print("Failure! Error: \(error)")
        completed()
      }
    }
}
