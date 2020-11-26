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
  
  @State private var selectedCondition = Condition.new
  let ownerId: Int
  @State var showInApp: Bool = false

  @State var name: String = ""
  @State var cost: String = ""
  @State var description: String = ""
  @State var lon: String = ""
  @State var lat: String = ""
  @State var category: String = ""
  @State var condition: String = ""
  var categoryOptions = ["Camping", "Cleaning", "Cleaning", "Gardening", "Hand Tools", "Kitchen", "Outdoor", "Painting", "Power Tools", "Safety", "Miscellaneous"]
  
    var body: some View {
      if showInApp {
        InAppView()
      } else {
      VStack {
        Text("Add a New Tool")
          .font(.largeTitle)
        Form {
          Section(header: Text("Tool information")) {
            TextField("Tool Name", text: $name)
            TextField("Cost Per Hour", text: $cost).keyboardType(.decimalPad)
            TextField("Description", text: $description)
              .frame(height: 100.0)
            Picker(selection: $category, label: Text("Category")) {
              ForEach(0 ..< categoryOptions.count) {
                Text(self.categoryOptions[$0])
              }
            }
          }
          Section(header: Text("Location")) {
            TextField("Longitude", text: $lon).keyboardType(.decimalPad)
            TextField("Latitude", text: $lat).keyboardType(.decimalPad)
          }
          Section(header: Text("Condition")) {
            Picker(selection: $selectedCondition, label: Text("Condition")) /*@START_MENU_TOKEN@*/{
              Text("New").tag(Condition.new)
              Text("Great").tag(Condition.great)
              Text("Good").tag(Condition.good)
              Text("Fair").tag(Condition.fair)
              Text("Poor").tag(Condition.poor)
            }/*@END_MENU_TOKEN@*/
          }
          Section(header: Text("Images")) {
            Text("Add Images here")
          }
        }
        
        Button(action: {
          let loca = GeoLocationInput(lat: Double(lat)!, lon: Double(lon)!)
          let cond = ToolCondition(rawValue: selectedCondition.rawValue)
          let newInput = NewToolInput(condition: cond!, description: description, hourlyCost: Double(cost)!, images: ["test"], location: loca, name: name, ownerId: ownerId, tags: ["test"])
          
          addTool(input: newInput)
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


enum Condition: String, CaseIterable, Identifiable {
    case new
    case great
    case good
    case fair
    case poor

    var id: String { self.rawValue }
}
