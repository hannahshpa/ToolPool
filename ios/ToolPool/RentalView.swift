//
//  RentalView.swift
//  ToolPool
//
//  CS 130 Group 8
//

import SwiftUI


struct RentalView: View {
    var body: some View {
        NavigationView {
            List{
                //usually fetch list of rentals with this user id
                //may have to makes seperate queries for rentals based on time/approval
                //for each rental make navlink passing in rental obj
                Section(header: Text("Pending Rentals")) //may need to make sections link to own pages if there are too many rentals
                {
                    NavigationLink(destination: ManagePendingResPage(toolName: "tool1")) {
                        Text("tool1")
                    }
                    NavigationLink(destination: ManagePendingResPage(toolName: "tool1")) {
                        Text("tool2")
                    }
                    NavigationLink(destination: ManagePendingResPage(toolName: "tool1")) {
                        Text("tool3")
                    }
                }
                Section(header: Text("Upcoming Rentals"))
                {
                    NavigationLink(destination: ManageUpcomingResPage(toolName: "tool1")) {
                        Text("tool4")
                    }
                    NavigationLink(destination: ManageUpcomingResPage(toolName: "tool1")) {
                        Text("tool5")
                    }
                    NavigationLink(destination: ManageUpcomingResPage(toolName: "tool1")) {
                        Text("tool6")
                    }
                }
                Section(header: Text("Past Rentals"))
                {
                    NavigationLink(destination: ManagePastResPage(toolName: "tool1")) {
                        Text("tool7")
                    }
                    NavigationLink(destination: ManagePastResPage(toolName: "tool1")) {
                        Text("tool8")
                    }
                    NavigationLink(destination: ManagePastResPage(toolName: "tool1")) {
                        Text("tool9")
                    }
                }
            }
            .navigationBarTitle("My Rentals", displayMode: .large)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct RentalView_Previews: PreviewProvider {
    static var previews: some View {
        RentalView()
    }
}
