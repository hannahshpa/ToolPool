//
//  MakeReservationView.swift
//  ToolPool
//
//  Created by Hannah Park on 11/17/20.
//

import SwiftUI

struct MakeReservationView: View {
    let date: Date
    @State var startDate = Date()
    @State var endDate = Date()
    init(date: Date) {
        self.date = date
        self._startDate = State(initialValue: date)
        self._endDate = State(initialValue: date)
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
                Text("Make Reservation")
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

struct MakeReservationView_Previews: PreviewProvider {
    static var previews: some View {
        MakeReservationView(date:Date())
    }
}
