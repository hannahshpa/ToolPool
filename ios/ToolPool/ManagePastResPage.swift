//
//  ManagePastRePage.swift
//  ToolPool
//
//  Created by Alissa McNerney on 11/12/20.
//

import SwiftUI

struct ManagePastResPage: View {
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
                //Text("Start: \(NSDate(timeIntervalSinceReferenceDate: TimeInterval(borrow.loanPeriod.start)!) )")
                //Text("Cost: \(borrow.cost)")
                Text("Location: (insert map)")
                Text("Rental Rating: (insert rating)")
                Text("Owner: " + borrow.tool.owner.name)
                Text("Email: \( borrow.tool.owner.email)")
                Text("Phone Number: \(borrow.tool.owner.phoneNumber)")
            }
            Divider()
            NavigationLink(destination: ToolListingPage(listingName: borrow.tool.name, categoryName: "")) {
                Text("Rent Again")
                    .frame(minWidth:0, maxWidth:325)
                    .background(Color.orange)
                    .font(.title)
                    .foregroundColor(.white)
                    .cornerRadius(40)
            }
          }
        }
      }
      .navigationBarTitle(Text("Past Rental"), displayMode: .inline)
    }
}

struct ManagePastResPage_Previews: PreviewProvider {
    static var previews: some View {
        ManagePastResPage(borrow: nil)
    }
}
