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
  
  let ownerId: Int
  @State var showInApp: Bool = false

  @State var name: String = ""
  @State var cost: String = ""
  @State var description: String = ""
  @State var city: String = ""
  @State var state: String = ""
  @State var category: String = ""
  @State var condition: String = ""
  var categoryOptions = ["Camping", "Cleaning", "Cleaning", "Gardening", "Hand Tools", "Kitchen", "Outdoor", "Painting", "Power Tools", "Safety", "Miscellaneous"]
  
  func toJson() -> [String: Any] {
    let jsonObject: [String: Any] = [
        "name": name,
        "description": "test",
        "location": [
            "lat": 10,
            "lon": 10
        ],
        "condition": "fair",
        "hourlyCost": 1.28,
        "tags": ["test"],
        "images": ["http://foo.bar"],
        "ownerId": ownerId
    ]
    return jsonObject
  }
  
    var body: some View {
      if showInApp {
          ProfileView()
      } else {
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
          
          let loca = GeoLocationInput(lat: 10, lon: 10)
          
          let cond = ToolCondition(rawValue: "fair")
          
          let newInput = NewToolInput(condition: cond!, description: "test", hourlyCost: 1.28, images: ["test"], location: loca, name: "test", ownerId: ownerId, tags: ["test"])
          
          addTool(input: newInput)
          
          //self.mode.wrappedValue.dismiss()
          self.showInApp = true

        }){
          Text("Submit Tool")
        }
        }
      }
    }
}

struct AddToolView_Previews: PreviewProvider {
    static var previews: some View {
      AddToolView(ownerId: 1)
    }
}

/*
class ToolToAdd {
  var name: String = ""
  var description: String = ""
  var lon: Float = 0
  var lat: Float = 0
  var condition: String = ""
  var hourlyCost: Float = 0
  var tags: String = ""
  var images: String = ""
  var ownerID: String = ""
  
  init() {
    
  }

}*/

func addTool(input: NewToolInput) {
  
  Network.shared.apollo.perform(mutation: AddToolMutation(tool: input)) { result in
    switch result {
    case .success(let graphQLResult):
      print("Success! Result: \(graphQLResult)")
    case .failure(let error):
      print("Failure! Error: \(error)")
    }
  }
}
