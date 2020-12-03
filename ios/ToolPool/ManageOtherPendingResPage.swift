//
//  ManageOtherPendingResPage.swift
//  ToolPool
//
//  Created by Alissa McNerney on 11/26/20.
//

import SwiftUI

struct ManageOtherPendingResPage: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    let borrow: GetOtherBorrowsQuery.Data.Self.OwnedTool.BorrowHistory!
    var body: some View {
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
                Text("Location: (insert map)")
                Text("User: " + borrow.user.name)
                Text("Email: \( borrow.user.email)")
                Text("Phone Number: \(borrow.user.phoneNumber)")
                
            }
            Divider()
            Button(action: {
                approveRental(borrow_id: borrow.id)
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
                denyRental(borrow_id: borrow.id)
                RentalView()
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

struct ManageOtherPendingResPage_Previews: PreviewProvider {
    static var previews: some View {
        ManageOtherPendingResPage(borrow: nil)
    }
}

func approveRental(borrow_id: Int) {
  
  Network.shared.apollo.perform(mutation: ApproveBorrowMutation(id: borrow_id)) { result in
    switch result {
    case .success(let graphQLResult):
      print("Success! Result: \(graphQLResult)")
    case .failure(let error):
      print("Failure! Error: \(error)")
    }
  }
}
func denyRental(borrow_id: Int) {
  
  Network.shared.apollo.perform(mutation: DenyBorrowMutation(id: borrow_id)) { result in
    switch result {
    case .success(let graphQLResult):
      print("Success! Result: \(graphQLResult)")
    case .failure(let error):
      print("Failure! Error: \(error)")
    }
  }
}
