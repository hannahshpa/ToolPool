//
//  OtherRentalView.swift
//  ToolPool
//
//  Created by Alissa McNerney on 11/20/20.
//

import SwiftUI

struct OtherRentalView: View {
    @ObservedObject private var borrowData: BorrowData = BorrowData()
    var body: some View {
        NavigationView {
            List{
                //usually fetch list of rentals with this user id
                //may have to makes seperate queries for rentals based on time/approval
                //for each rental make navlink passing in rental obj
                Section(header: Text("Pending Rentals"))  //may need to make sections link to own pages if there are too many rentals
                {
                    NavigationLink(destination: ManagePendingResPage(borrow: borrowData.borrows[0])) {
                        Text((borrowData.borrows[0]?.loanPeriod.start)! + ": " + (borrowData.borrows[0]?.tool.name)! )
                    }
                    NavigationLink(destination: ManagePendingResPage(borrow: borrowData.borrows[1])) {
                        Text((borrowData.borrows[1]?.loanPeriod.start)! + ": " + (borrowData.borrows[1]?.tool.name)! )
                    }
                }
                Section(header: Text("Upcoming Rentals"))
                {
                    NavigationLink(destination: ManageUpcomingResPage(borrow: borrowData.borrows[0])){
                        Text((borrowData.borrows[0]?.loanPeriod.start)! + ": " + (borrowData.borrows[0]?.tool.name)! )
                    }
                    NavigationLink(destination: ManageUpcomingResPage(borrow: borrowData.borrows[1])){
                        Text((borrowData.borrows[1]?.loanPeriod.start)! + ": " + (borrowData.borrows[1]?.tool.name)! )
                    }
                }
                Section(header: Text("Past Rentals"))
                {
                    NavigationLink(destination: ManagePastResPage(borrow: borrowData.borrows[0])){
                        Text((borrowData.borrows[0]?.loanPeriod.start)! + ": " + (borrowData.borrows[0]?.tool.name)! )
                    }
                    NavigationLink(destination: ManagePastResPage(borrow: borrowData.borrows[1])){
                        Text((borrowData.borrows[1]?.loanPeriod.start)! + ": " + (borrowData.borrows[1]?.tool.name)! )
                    }
                }
            }
            .navigationBarTitle("Other Tool Rentals", displayMode: .automatic)
            .navigationBarBackButtonHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .edgesIgnoringSafeArea(.top)
    }
}

/*List(borrowData.borrows, id: \.cost) { b in
    NavigationLink(destination: ManageUpcomingResPage(toolName: "tool1")) {
        Text(b!.tool.name)
    }
    
}*/

struct OtherRentalView_Previews: PreviewProvider {
    static var previews: some View {
        OtherRentalView()
    }
}
