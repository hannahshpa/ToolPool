//
//  ManagePastRePage.swift
//  ToolPool
//
//  Created by Alissa McNerney on 11/12/20.
//

import SwiftUI

struct ManagePastResPage: View {
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
            Text("Date: " + borrow.loanPeriod.start)
            Text("User: " + borrow.user.name)
            Text("Cost: \(borrow.cost)")
            Text("Location: (insert map)")
            Text("Rental Rating: (insert rating)")
            NavigationLink(destination: ToolListingPage(listingName: borrow.tool.name)) {
                Text("Rent Again")
            }
          }
        }
      }
    }
}

struct ManagePastResPage_Previews: PreviewProvider {
    static var previews: some View {
        ManagePastResPage(borrow: nil)
    }
}
