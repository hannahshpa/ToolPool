//
//  AddToolView.swift
//  ToolPool
//
//  Created by Olsen on 11/5/20.
//

import SwiftUI

struct AddToolView: View {
  
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  @Environment(\.managedObjectContext) var moc


  @State var name: String = ""
  @State var cost: String = ""
  @State var description: String = ""
  @State var city: String = ""
  @State var state: String = ""
  @State var category: String = ""
  @State var condition: String = ""
  var categoryOptions = ["Camping", "Cleaning", "Cleaning", "Gardening", "Hand Tools", "Kitchen", "Outdoor", "Painting", "Power Tools", "Safety", "Miscellaneous"]
  
    var body: some View {
      VStack {
        Text("Add a New Tool")
          .font(.largeTitle)
        Form {
          Section(header: Text("Tool information")) {
            TextField("Tool Name", text: $name)
            TextField("Cost Per Hour", text: $cost)
            TextField("City", text: $city)
            TextField("State", text: $state)
            TextField("Description", text: $description)
              .frame(height: 100.0)
            Picker(selection: $category, label: Text("Category")) {
              ForEach(0 ..< categoryOptions.count) {
                Text(self.categoryOptions[$0])
              }
            }
          }
          Section(header: Text("Condition")) {
            Picker(selection: $condition, label: Text("Condition")) /*@START_MENU_TOKEN@*/{
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
        Button(action: {
          
          self.mode.wrappedValue.dismiss()
          /*
          let newTool = Tool(context: self.moc)
          newTool.category = self.category
          newTool.city = self.city
          newTool.condition = self.state
          newTool.descriptiontext = self.description
          newTool.owner = "test"
          newTool.price = 0
          newTool.rating = 0
          newTool.state = ""
          newTool.title = self.name

          //try? self.moc.save()
          */
        }) {
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

/*
func addTool() {
  Network.shared.apollo.perform(mutation: AddToolMutation(tool: ["test", "test"])) { result in
    switch result {
    case .success(let graphQLResult):
      print("Success! Result: \(graphQLResult)")
    case .failure(let error):
      print("Failure! Error: \(error)")
    }
  }
}*/
