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
    @State var imDone4: Bool = false
    var body: some View {
        if imDone4 {
          RentalView()
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
                Text("Owner: " + borrow.tool.owner.name)
                Text("Email: \( borrow.tool.owner.email)")
                Text("Phone Number: \(borrow.tool.owner.phoneNumber)")
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
            Button(action: {
                returnTool(completed_borrow: borrow){}
                self.imDone4 = true
            }) {
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
      .navigationBarTitle(Text("Current Rental"), displayMode: .inline)
    }
    }
}

struct ManageUpcomingResPage_Previews: PreviewProvider {
    static var previews: some View {
        ManageUpcomingResPage(borrow: nil)
    }
}

func returnTool (completed_borrow: GetBorrowsQuery.Data.Self.BorrowHistory!, completed: @escaping () -> ()) {
    Network.shared.apollo.clearCache()
    Network.shared.apollo.perform(mutation: ReturnToolMutation(borrowId: completed_borrow.id)) { result in
      switch result {
      case .success(let graphQLResult):
        print("Success! Result: \(graphQLResult)")
        completed()
      case .failure(let error):
        print("Failure! Error: \(error)")
          completed()
      }
    }

}
