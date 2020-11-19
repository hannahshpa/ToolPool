//
//  RentalView.swift
//  ToolPool
//
//  CS 130 Group 8
//

import SwiftUI

struct User: Identifiable {
    var id = UUID()
    var cost: Float
}

struct RentalView: View {
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
            .navigationBarTitle("My Rentals", displayMode: .large)
            .navigationBarBackButtonHidden(true)
        }
    }
}

/*List(borrowData.borrows, id: \.cost) { b in
    NavigationLink(destination: ManageUpcomingResPage(toolName: "tool1")) {
        Text(b!.tool.name)
    }
    
}*/

struct RentalView_Previews: PreviewProvider {
    static var previews: some View {
        RentalView()
    }
}

class BorrowData: ObservableObject {
    @Published var borrows: [BorrowByIdQuery.Data.Borrow?]!
    
    init() {
        print("running loadData")
        self.borrows = []
        loadData()
    }
    
    func loadData() {
        Network.shared.apollo.fetch(query: BorrowByIdQuery(id: 1)) { result in
          switch result {
          case .success(let graphQLResult):
            let cur = graphQLResult.data?.borrow
            if cur != nil {
                self.borrows.append(cur)
            }
            print("Success! Result: \(String(describing: self.borrows))")
          case .failure(let error):
            print("Failure! Error: \(error)")
          }
        }
        Network.shared.apollo.fetch(query: BorrowByIdQuery(id: 2)) { result in
          switch result {
          case .success(let graphQLResult):
            let cur = graphQLResult.data?.borrow
            if cur != nil {
                self.borrows.append(cur)
            }
            print("Success! Result: \(String(describing: self.borrows))")
          case .failure(let error):
            print("Failure! Error: \(error)")
          }
        }
    }
}
