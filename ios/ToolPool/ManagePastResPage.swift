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
                .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                .aspectRatio(contentMode: .fit)
            Text(borrow.tool.name)
                .font(.title)
                .foregroundColor(.black)
            Divider()
            Group {
                Text("Date: " + borrow.loanPeriod.start)
                Text("Cost: \(borrow.cost)")
                Text("Location: (insert map)")
                Text("Rental Rating: (insert rating)")
                NavigationLink(destination:OtherProfilePage(user: borrow.user)) {
                    Text("User: " + borrow.user.name)
                }
            }
            Divider()
            NavigationLink(destination: ToolListingPage(listingName: borrow.tool.name)) {
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
