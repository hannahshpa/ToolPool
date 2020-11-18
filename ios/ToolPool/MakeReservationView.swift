//
//  MakeReservationView.swift
//  ToolPool
//
//  Created by Hannah Park on 11/17/20.
//

import SwiftUI

struct MakeReservationView: View {
    let date: Date
    @State var selectedDate = Date()
    init(date: Date) {
        self.date = date
        self._selectedDate = State(initialValue: date)
    }
    var body: some View {
        VStack {
            Form {
                Section {
                    DatePicker("Start Date", selection: $selectedDate, displayedComponents: .date)
                }
                Section {
                    DatePicker("Start Time", selection: $selectedDate, displayedComponents: .hourAndMinute)
                }
                Section {
                    DatePicker("End Date", selection: $selectedDate, displayedComponents: .date)

                }
                Section {
                    DatePicker("End Time", selection: $selectedDate, displayedComponents: .hourAndMinute)
                }
            }
            NavigationLink(destination:SearchView()) { // todo: change to make reservation
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
