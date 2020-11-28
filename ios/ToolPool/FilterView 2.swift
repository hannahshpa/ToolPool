//
//  FilterView.swift
//  ToolPool
//
//  Created by Hannah Park on 11/8/20.
//

import SwiftUI

struct FilterView: View {
    var prices = ["$0 - $5", "$5 - $10", "$10 - $15", "$15 - $20", "$20+"]
    var distances = ["Within 1 mile", "5 miles", "10 miles", "25 miles", "50 miles", "50+ miles"]
    var conditions = ["All", "New", "Like New", "Good", "Used"]
    var ratings = ["5 stars", "4 stars and up", "3 stars and up", "2 stars and up", "1 star and up"]
    @State private var selectedPriceRangeIndex = 0
    @State private var selectedDistanceIndex = 0
    @State private var selectedConditionIndex = 0
    @State private var selectedRatingIndex = 0
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $selectedPriceRangeIndex, label: Text("Price Range")) {
                        ForEach(0 ..< prices.count) {
                            Text(self.prices[$0])
                        }
                    }
                    Picker(selection: $selectedDistanceIndex, label: Text("Distance")) {
                        ForEach(0 ..< distances.count) {
                            Text(self.distances[$0])
                        }
                    }
                    Picker(selection: $selectedConditionIndex, label: Text("Condition")) {
                        ForEach(0 ..< conditions.count) {
                            Text(self.conditions[$0])
                        }
                    }
                    Picker(selection: $selectedRatingIndex, label: Text("Rating")) {
                        ForEach(0 ..< ratings.count) {
                            Text(self.ratings[$0])
                        }
                    }
                }
            }
            .navigationBarTitle("Filter")
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
