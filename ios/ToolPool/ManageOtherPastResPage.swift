//
//  ManageOtherPastResPage.swift
//  ToolPool
//
//  Created by Alissa McNerney on 11/26/20.
//

import SwiftUI

struct ManageOtherPastResPage: View {
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
                //Text("Date: " + borrow.loanPeriod.start)
                Text("Cost: \(borrow.cost)")
                Text("Location: (insert map)")
                Text("Rental Rating: (insert rating)")
                Text("User: " + borrow.user.name)
                Text("Email: \( borrow.user.email)")
                Text("Phone Number: \(borrow.user.phoneNumber)")
            }
          }
        }
      }
      .navigationBarTitle(Text("Past Rental"), displayMode: .inline)
    }
}

struct ManageOtherPastResPage_Previews: PreviewProvider {
    static var previews: some View {
        ManageOtherPastResPage(borrow: nil)
    }
}