//
//  MakeReservationView.swift
//  ToolPool
//
//  Created by Hannah Park on 11/17/20.
//

import SwiftUI

struct MakeReservationView: View {
    let date: Date
    let toolId: Int
    @State var startDate = Date()
    @State var endDate = Date()
    @ObservedObject var selfData: mySelf = mySelf()

    init(date: Date, toolId:Int) {
        self.date = date
        self.toolId = toolId
        self._startDate = State(initialValue: date)
        self._endDate = State(initialValue: date)
        self.selfData.load()
    }
    var body: some View {
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
            NavigationLink(destination:InAppView()) { // todo: change to make reservation
                Text("Request Reservation")
                    .frame(minWidth:0, maxWidth:300)
                    .background(Color.orange)
                    .font(.title)
                    .foregroundColor(.white)
                    .cornerRadius(40)
            }
            .simultaneousGesture(TapGesture().onEnded{
                requestRental(userId:selfData.data.id, startTime:String(startDate.timeIntervalSinceReferenceDate), endTime:String(endDate.timeIntervalSinceReferenceDate), toolId: toolId)
            })
        }
        .navigationTitle("Reservation Details")
    }
}

struct MakeReservationView_Previews: PreviewProvider {
    static var previews: some View {
        MakeReservationView(date:Date(), toolId: 0)
    }
}

func requestRental(userId:Int, startTime:String, endTime:String, toolId:Int) {
  
  Network.shared.apollo.perform(mutation: RequestBorrowMutation(userId: userId, startTime: startTime, endTime: endTime, toolId: toolId)) { result in
    switch result {
    case .success(let graphQLResult):
      print("Success! Result: \(graphQLResult)")
    case .failure(let error):
      print("Failure! Error: \(error)")
    }
  }
}
