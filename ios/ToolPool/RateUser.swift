//
//  RateRental.swift
//  ToolPool
//
//  Created by Alissa McNerney on 11/13/20.
//

import SwiftUI

struct RateUser: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    let completed_borrow: GetOtherBorrowsQuery.Data.Self.OwnedTool.BorrowHistory!
    @State var imDoneUser: Bool = false
    //let geometry: GeometryProxy
    @State var description: String = ""
    var body: some View {
        if imDoneUser {
          OtherRentalView()
        } else {
        VStack {
            Text("Rate This Tool").font(.largeTitle)
            Divider()
            /*Form {
                TextField("Review", text: $description)
                  .frame(height: 100.0)*/
                HStack { // position views horizontally
                    Button(action: {
                        
                        rateUser(borrow_id: completed_borrow.id, other_user_id: completed_borrow.user.id, rev: description, user_id: completed_borrow.tool.owner.id, num_rating: 1){}
                        self.imDoneUser = true
                    }) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundColor(Color.gray)
                            .aspectRatio(contentMode: .fit)}
                    Button(action: {
                        
                        rateUser(borrow_id: completed_borrow.id, other_user_id: completed_borrow.user.id, rev: description, user_id: completed_borrow.tool.owner.id, num_rating: 2){}
                        self.imDoneUser = true
                    }) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundColor(Color.gray)
                            .aspectRatio(contentMode: .fit)}
                    Button(action: {
                        rateUser(borrow_id: completed_borrow.id, other_user_id: completed_borrow.user.id, rev: description, user_id: completed_borrow.tool.owner.id, num_rating: 3){}
                        self.imDoneUser = true
                    }) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundColor(Color.gray)
                            .aspectRatio(contentMode: .fit)}
                    Button(action: {
                        rateUser(borrow_id: completed_borrow.id, other_user_id: completed_borrow.user.id, rev: description, user_id: completed_borrow.tool.owner.id, num_rating: 4){}
                        self.imDoneUser = true
                    }) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundColor(Color.gray)
                            .aspectRatio(contentMode: .fit)}
                    Button(action: {
                        rateUser(borrow_id: completed_borrow.id, other_user_id: completed_borrow.user.id, rev: description, user_id: completed_borrow.tool.owner.id, num_rating: 5) {}
                        self.imDoneUser = true
                    }) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundColor(Color.gray)
                            .aspectRatio(contentMode: .fit)}
                }
            }.navigationBarHidden(true)
        }
    //}
}

func rateUser(borrow_id: Int, other_user_id: Int, rev: String, user_id: Int, num_rating: Int, completed: @escaping () -> ()) {
    Network.shared.apollo.clearCache()
    Network.shared.apollo.perform(mutation: AcceptReturnMutation(borrowId: borrow_id, accept: true)) { result in
      switch result {
      case .success(let graphQLResult): do {
        print("Success! Result: \(graphQLResult)")
        Network.shared.apollo.perform(mutation: CreateUserRatingMutation(revieweeId: other_user_id , review: rev, reviewerId: user_id, rating: num_rating)) { result in
          switch result {
          case .success(let graphQLResult):
            print("Success! Result: \(graphQLResult)")
            completed()
          case .failure(let error):
            print("Failure! Error: \(error)")
            completed()
          }
        }
      }
      case .failure(let error):
        print("Failure! Error: \(error)")
        completed()
      }
    }
  
}}
