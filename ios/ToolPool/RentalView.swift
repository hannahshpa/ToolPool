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
    @ObservedObject private var borrowsData: myBorrows = myBorrows()
    init() {
        self.borrowsData.load()
    }
    var body: some View {
            NavigationView {
                List{
                        Section(header: Text("Pending Rentals"))
                        {
                            ForEach(borrowsData.data.borrows, id: \.id) { b in
                                if b.status == .pending {
                                    NavigationLink(destination: ManagePendingResPage(borrow: b)) {
                                        Text("\(NSDate(timeIntervalSinceReferenceDate: TimeInterval(b.loanPeriod.start))) : \(b.tool.name)")
                                    }
                                }
                            }
                        }
                        Section(header: Text("Current Rentals"))
                        {
                            ForEach(borrowsData.data.borrows, id: \.id) { b in
                                if b.status == .accepted && b.timeReturned == nil{
                                    NavigationLink(destination: ManageUpcomingResPage(borrow: b)) {
                                        Text("\(NSDate(timeIntervalSinceReferenceDate: TimeInterval(b.loanPeriod.start))) : \(b.tool.name)")
                                    }
                                }
                            }
                        }
                        Section(header: Text("Past Rentals"))
                        {
                            ForEach(borrowsData.data.borrows, id: \.id) { b in
                                if b.status == .accepted && b.timeReturned != nil {
                                NavigationLink(destination: ManagePastResPage(borrow: b)) {
                                    Text("\(NSDate(timeIntervalSinceReferenceDate: TimeInterval(b.loanPeriod.start))) : \(b.tool.name)")
                                }
                            }
                
                        }
                        }
                    
                    
                   }
                //.onAppear(perform: borrowsData.load)
                .navigationBarTitle("My Tool Rentals", displayMode: .automatic)
                .navigationBarBackButtonHidden(true)
                //.navigationBarBackButtonHidden(true)
                   //.navigationViewStyle(StackNavigationViewStyle())
                   .edgesIgnoringSafeArea(.top)
               }
            .edgesIgnoringSafeArea(.top)
            }
    
}



struct RentalView_Previews: PreviewProvider {
    static var previews: some View {
        RentalView()
    }
}

class borrowObj {
    var borrows: [GetBorrowsQuery.Data.Self.BorrowHistory] = []
  
    init(b: [GetBorrowsQuery.Data.Self.BorrowHistory]) {
        self.borrows = b
    }
}

class myBorrows: ObservableObject {

  @Published var data: borrowObj {
    willSet {
        objectWillChange.send()
    }
  }
    
    init() {
        self.data = borrowObj(b: [])
        self.load()
    }
  
    func load() {
        Network.shared.apollo.clearCache()
     Network.shared.apollo.fetch(query: GetBorrowsQuery()) { result in
       switch result {
       case .success(let graphQLResult):
          print("Success! Result: \(graphQLResult)")
        if let temp_history = graphQLResult.data?.`self`?.borrowHistory {
            self.objectWillChange.send()
            self.data = borrowObj(b: temp_history)
            print("updated-----------------")
            
          }
       case .failure(let error):
         print("Failure! Error: \(error)")
       }
     }
    }
  
}
 
 
