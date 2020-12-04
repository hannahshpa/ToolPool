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
//                Text("Location: (insert map)")
                Text("Owner: " + borrow.tool.owner.name)
                Text("Email: \( borrow.tool.owner.email)")
                Text("Phone Number: \(borrow.tool.owner.phoneNumber)")
            }
            Divider()
            if (borrow.returnAccepted == true) {
                Text("This return has been completed and accepted")
                    .font(.caption)
                NavigationLink(destination: RateTool(completed_borrow: borrow)) {
                    Text("Rate Tool")
                        .frame(minWidth:0, maxWidth:325)
                        .background(Color.orange)
                        .font(.title)
                        .foregroundColor(.white)
                        .cornerRadius(40)
                }
            } else if (borrow.returnAccepted == false) {
                Text("This rental has been reported as unreturned by the owner")
                    .font(.caption)
            } else {
                Text("This return is awaiting approval by the owner")
                    .font(.caption)
            }
            Divider()
            NavigationLink(destination: ToolListingPage(borrow.tool.name,id: borrow.tool.id, category: borrow.tool.tags[0])) {
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
