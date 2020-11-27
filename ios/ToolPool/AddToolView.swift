//
//  AddToolView.swift
//  ToolPool
//
//  Created by Olsen on 11/5/20.
//

import SwiftUI
import UIKit


struct AddToolView: View {
  
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  @Environment(\.managedObjectContext) var moc
  
  @State private var selectedCondition = Condition.new
  let ownerId: Int
  @State var showInApp: Bool = false
  
  @State private var isShowPhotoLibrary = false
  @State private var image = UIImage()

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
            TextField("Cost Per Hour", text: $cost).keyboardType(.numberPad)
            TextField("Description", text: $description)
              .frame(height: 100.0)
            Picker(selection: $category, label: Text("Category")) {
              ForEach(0 ..< categoryOptions.count) {
                Text(self.categoryOptions[$0])
              }
            }
          }
          Section(header: Text("Location")) {
            TextField("Longitude", text: $lon).keyboardType(.numberPad)
            TextField("Latitude", text: $lat).keyboardType(.numberPad)
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
            Button(action: {
                            self.isShowPhotoLibrary = true
                        }) {
                            HStack {
                                Image(systemName: "photo")
                                    .font(.system(size: 20))
             
                                Text("Photo library")
                                    .font(.headline)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .padding(.horizontal)
                        }
            Image(uiImage: self.image)
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .edgesIgnoringSafeArea(.all)
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
        }.sheet(isPresented: $isShowPhotoLibrary) {
          ImagePicker(selectedImage: self.$image, sourceType: .photoLibrary)
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


struct ImagePicker: UIViewControllerRepresentable {

  @Binding var selectedImage: UIImage
  @Environment(\.presentationMode) var presentationMode
  var sourceType: UIImagePickerController.SourceType = .photoLibrary
  
  func makeCoordinator() -> Coordinator {
      Coordinator(self)
  }
 
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
 
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
 
        return imagePicker
    }
 
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
 
    }
  
}

final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    var parent: ImagePicker
 
    init(_ parent: ImagePicker) {
        self.parent = parent
    }
  
    
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
 
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            parent.selectedImage = image
        }
 
        parent.presentationMode.wrappedValue.dismiss()
    }
}
