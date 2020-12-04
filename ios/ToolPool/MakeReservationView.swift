//
//  MakeReservationView.swift
//  ToolPool
//
//  Created by Hannah Park on 11/17/20.
//

import SwiftUI
import Foundation

struct MakeReservationView: View {
    let date: Date
    let toolId: Int
    @State var startDate = Date()
    @State var endDate = Date()
    @ObservedObject var selfData: mySelf = mySelf()
    @State var imDoneRes: Bool = false
    init(date: Date, toolId:Int) {
        self.date = date
        self.toolId = toolId
        self._startDate = State(initialValue: date)
        self._endDate = State(initialValue: date)
        self.selfData.load()
    }
    var body: some View {
        if imDoneRes {
          InAppView()
        } else {
        VStack {
            Form {
                Section {
                    DatePicker("Start Date", selection: $startDate, in: Date()..., displayedComponents: .date)
                }
                Section {
                    DatePicker("Start Time", selection: $startDate, in: Date()..., displayedComponents: .hourAndMinute)
                }
                Section {
                    DatePicker("End Date", selection: $endDate, in: Date()..., displayedComponents: .date)
                }
                Section {
                    DatePicker("End Time", selection: $endDate, in: Date()..., displayedComponents: .hourAndMinute)
                }
                
            }
            Button(action: {
                requestRental(userId:selfData.data.id, startTime:Double(startDate.timeIntervalSinceReferenceDate), endTime:Double(endDate.timeIntervalSinceReferenceDate), toolId: toolId){}
                self.imDoneRes = true
            }) { Text("Request Reservation")
                .frame(minWidth:0, maxWidth:300)
                .background(Color.orange)
                .font(.title)
                .foregroundColor(.white)
                .cornerRadius(40)
            }
        }
        .navigationTitle("Reservation Details")
    }
    }
}

struct MakeReservationView_Previews: PreviewProvider {
    static var previews: some View {
        MakeReservationView(date:Date(), toolId: 0)
    }
}

func requestRental(userId:Int, startTime:Double, endTime:Double, toolId:Int, completed: @escaping () -> ()) {
    Network.shared.apollo.clearCache()
  Network.shared.apollo.perform(mutation: RequestBorrowMutation(userId: userId, startTime: startTime, endTime: endTime, toolId: toolId)) { result in
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
