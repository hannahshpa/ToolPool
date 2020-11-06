//
//  SearchView.swift
//  ToolPool
//
//  CS 130 Group 8
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Hello World")
                }
            }
            .navigationBarTitle("Find Tools", displayMode:.inline)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
