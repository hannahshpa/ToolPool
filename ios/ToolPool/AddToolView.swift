//
//  AddToolView.swift
//  ToolPool
//
//  Created by Olsen on 11/5/20.
//

import SwiftUI

struct AddToolView: View {
  
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>

  @State var name: String = ""
  @State var cost: String = ""
  @State var description: String = ""
  @State var city: String = ""
  @State var state: String = ""
  
    var body: some View {
      VStack {
        Text("Add a New Tool")
          .font(.largeTitle)
        Form {
          Section(header: Text("Tool information")) {
            TextField("Tool Name", text: $name)
            TextField("Cost Per Hour", text: $cost)
            TextField("Description", text: $description)
              .frame(height: 100.0)
          }
          Section(header: Text("Condition")) {
            Picker(selection: .constant(1), label: Text("Condition")) /*@START_MENU_TOKEN@*/{
              Text("Brand New").tag(1)
              Text("Good").tag(2)
              Text("Poor").tag(3)
              Text("Bad").tag(4)
            }/*@END_MENU_TOKEN@*/
          }
          Section(header: Text("Images")) {
            Text("Add Images here")
          }
        }
        Button(action: {self.mode.wrappedValue.dismiss()}) {
          Text("Submit Tool")
        }
        /*
        NavigationLink(destination: ProfileView()) {
          Text("Submit New Tool")
            .foregroundColor(Color.black)
            .lineLimit(nil)
            .frame(width: 200.0)
            .background(Color.white)
            .padding()
            .border(Color.black, width:2)
        }*/
      }
    }
}

struct AddToolView_Previews: PreviewProvider {
    static var previews: some View {
        AddToolView()
    }
}
