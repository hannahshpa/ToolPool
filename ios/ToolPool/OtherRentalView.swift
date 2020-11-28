//
//  OtherRentalView.swift
//  ToolPool
//
//  Created by Alissa McNerney on 11/20/20.
//

import SwiftUI

struct OtherRentalView: View {
    @ObservedObject private var borrowsData: myOtherBorrows = myOtherBorrows()
    var body: some View {
            NavigationView {
                List{
                    //usually fetch list of rentals with this user id
                    //may have to makes seperate queries for rentals based on time/approval
                    //for each rental make navlink passing in rental obj
                        Section(header: Text("Pending Rentals"))
                        {
                            ForEach(borrowsData.data.borrows, id: \.id) { b in
                                if b.status == .pending {
                                    NavigationLink(destination: ManageOtherPendingResPage(borrow: b)) {
                                        Text(b.tool.name)
                                    }
                                }
                            }
                        }
                        Section(header: Text("Upcoming Rentals"))
                        {
                            ForEach(borrowsData.data.borrows, id: \.id) { b in
                                if b.status == .accepted {
                                    NavigationLink(destination: ManageOtherUpcomingResPage(borrow: b)) {
                                        Text(b.tool.name)
                                    }
                                }
                            }
                        }
                        Section(header: Text("Past (denied) Rentals"))
                        {
                            ForEach(borrowsData.data.borrows, id: \.id) { b in
                                if b.status == .rejected {
                                NavigationLink(destination: ManageOtherPastResPage(borrow: b)) {
                                    Text(b.tool.name)
                                }
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
    
}



class otherBorrowObj {
    var borrows: [GetOtherBorrowsQuery.Data.Self.OwnedTool.BorrowHistory] = []
  
    init(b: [GetOtherBorrowsQuery.Data.Self.OwnedTool.BorrowHistory]) {
        self.borrows = b
    }
}

struct OtherRentalView_Previews: PreviewProvider {
    static var previews: some View {
        OtherRentalView()
    }
}

class myOtherBorrows: ObservableObject {

  @Published var data: otherBorrowObj {
    willSet {
        objectWillChange.send()
    }
  }
    
    init() {
        self.data = otherBorrowObj(b:[])
        self.load()
    }
  
    func load() {
     Network.shared.apollo.fetch(query: GetOtherBorrowsQuery()) { result in
       switch result {
       case .success(let graphQLResult):
          print("Success! Result: \(graphQLResult)")
        var temp_borrows: [GetOtherBorrowsQuery.Data.`Self`.OwnedTool.BorrowHistory] = []
        if let tool_lists = graphQLResult.data?.`self`?.ownedTools {
            for tt in tool_lists {
                for bb in tt.borrowHistory {
                    temp_borrows.append(bb)
                }
            }
            self.objectWillChange.send()
            self.data = otherBorrowObj(b: temp_borrows)
            print("updated-----------------")
            
          }
       case .failure(let error):
         print("Failure! Error: \(error)")
       }
     }
    }
  
}
