//
//  RateTool.swift
//  ToolPool
//
//  Created by Alissa McNerney on 12/2/20.
//

import SwiftUI

struct RateTool: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    let completed_borrow: GetBorrowsQuery.Data.Self.BorrowHistory!
    //let geometry: GeometryProxy
    @State var description: String = ""
    var body: some View {
        VStack {
            Text("Rate This Tool").font(.largeTitle)
            Divider()
            Form {
                TextField("Review", text: $description)
                  .frame(height: 100.0)
                HStack { // position views horizontally
                    Button(action: {
                        rateTool(borrow_id: completed_borrow.id, tool_id: completed_borrow.tool.id, rev: description, user_id: completed_borrow.tool.owner.id, num_rating: 1)
                        self.mode.wrappedValue.dismiss()
                        self.mode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundColor(Color.gray)
                            .aspectRatio(contentMode: .fit)}
                    Button(action: {
                        rateTool(borrow_id: completed_borrow.id, tool_id: completed_borrow.tool.id, rev: description, user_id: completed_borrow.tool.owner.id, num_rating: 2)
                        self.mode.wrappedValue.dismiss()
                        self.mode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundColor(Color.gray)
                            .aspectRatio(contentMode: .fit)}
                    Button(action: {
                        rateTool(borrow_id: completed_borrow.id, tool_id: completed_borrow.tool.id, rev: description, user_id: completed_borrow.tool.owner.id, num_rating: 3)
                        self.mode.wrappedValue.dismiss()
                        self.mode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundColor(Color.gray)
                            .aspectRatio(contentMode: .fit)}
                    Button(action: {
                        rateTool(borrow_id: completed_borrow.id, tool_id: completed_borrow.tool.id, rev: description, user_id: completed_borrow.tool.owner.id, num_rating: 4)
                        self.mode.wrappedValue.dismiss()
                        self.mode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundColor(Color.gray)
                            .aspectRatio(contentMode: .fit)}
                    Button(action: {
                        rateTool(borrow_id: completed_borrow.id, tool_id: completed_borrow.tool.id, rev: description, user_id: completed_borrow.tool.owner.id, num_rating: 5)
                        self.mode.wrappedValue.dismiss()
                        self.mode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundColor(Color.gray)
                            .aspectRatio(contentMode: .fit)}
                }
            }
            
        }
    }
}

func rateTool(borrow_id: Int, tool_id: Int, rev: String, user_id: Int, num_rating: Int) {
    Network.shared.apollo.perform(mutation: ReturnToolMutation(borrowId: borrow_id)) { result in
      switch result {
      case .success(let graphQLResult):
        print("Success! Result: \(graphQLResult)")
      case .failure(let error):
        print("Failure! Error: \(error)")
      }
    }
  Network.shared.apollo.perform(mutation: CreateToolRatingMutation(revieweeId: tool_id , review: rev, reviewerId: user_id, rating: num_rating)) { result in
    switch result {
    case .success(let graphQLResult):
      print("Success! Result: \(graphQLResult)")
    case .failure(let error):
      print("Failure! Error: \(error)")
    }
  }
}
