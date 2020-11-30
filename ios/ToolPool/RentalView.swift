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
                                    NavigationLink(destination: ManagePendingResPage(borrow: b)) {
                                        Text(b.tool.name)
                                    }
                                }
                            }
                        }
                        Section(header: Text("Upcoming Rentals"))
                        {
                            ForEach(borrowsData.data.borrows, id: \.id) { b in
                                if b.status == .accepted {
                                    NavigationLink(destination: ManageUpcomingResPage(borrow: b)) {
                                        Text(b.tool.name)
                                    }
                                }
                            }
                        }
                        Section(header: Text("Past Rentals"))
                        {
                            ForEach(borrowsData.data.borrows, id: \.id) { b in
                                if b.status == .rejected {
                                NavigationLink(destination: ManagePastResPage(borrow: b)) {
                                    Text(b.tool.name)
                                }
                            }
                
                        }
                        }
                    
                    
                   }
                .navigationBarTitle("My Tool Rentals", displayMode: .automatic)
                //.navigationBarBackButtonHidden(true)
                   //.navigationViewStyle(StackNavigationViewStyle())
                   .edgesIgnoringSafeArea(.top)
               }
            .edgesIgnoringSafeArea(.top)
            }
    
}
                            
    /*var body: some View {
        GeometryReader {
            geometry in
            VStack {
                /*Text("My Rentals")
                    .font(.largeTitle)
                    .onAppear() {
                        self.borrowsData.objectWillChange.send()
                    }
            
                Divider()*/
                List {
                    Section(header: Text("Pending Rentals"))
                    {
                        NavigationLink(destination: ToolListingPage(listingName:"hi", categoryName:"camping")) {
                            Text("test")
                        }
                        ForEach(borrowsData.data.borrows, id: \.id) { b in
                            if b.status == .pending {
                                NavigationLink(destination: ManagePendingResPage(borrow: b)) {
                                    Text(b.tool.name)
                                }
                            }
                        }
                    }
                    Section(header: Text("Upcoming Rentals"))
                    {
                        ForEach(borrowsData.data.borrows, id: \.id) { b in
                            if b.status == .accepted {
                                NavigationLink(destination: ManageUpcomingResPage(borrow: b)) {
                                    Text(b.tool.name)
                                }
                            }
                        }
                    }
                    Section(header: Text("Past Rentals"))
                    {
                        ForEach(borrowsData.data.borrows, id: \.id) { b in
                            if b.status == .rejected {
                            NavigationLink(destination: ManagePastResPage(borrow: b)) {
                                Text(b.tool.name)
                            }
                        }
                    }
                    
                }
            }
        }
    
    }
    .navigationBarTitle("My Rentals", displayMode: .large)
}
     }*/



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
 
 
