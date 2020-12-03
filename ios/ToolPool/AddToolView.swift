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
  @State private var selectedCategory = Category.Camping
  let ownerId: Int
  @State var showInApp: Bool = false
  @ObservedObject var newTool = NewTool()
  
  @State private var isShowPhotoLibrary = false
  @State private var image = UIImage()
  @State var newToolID: Int = 0

  @State var name: String = ""
  @State var cost: String = ""
  @State var description: String = ""
  @State var lon: String = ""
  @State var lat: String = ""
  @State var category: String = ""
  @State var condition: String = ""
  var categoryOptions = ["Camping", "Cleaning", "Gardening", "Hand Tools", "Kitchen", "Outdoor", "Painting", "Power Tools", "Safety", "Miscellaneous"]
  
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
            Picker(selection: $selectedCategory, label: Text("Category")) /*@START_MENU_TOKEN@*/{
              Text("Camping").tag(Category.Camping)
              Text("Cleaning").tag(Category.Cleaning)
              Text("Gardening").tag(Category.Gardening)
              Text("Hand Tools").tag(Category.Hand_Tools)
              Text("Kitchen").tag(Category.Kitchen)
              Text("Outdoor").tag(Category.Outdoor)
              Text("Painting").tag(Category.Painting)
              Text("Power Tools").tag(Category.Power_Tools)
              Text("Hand_Tools").tag(Category.Hand_Tools)
              Text("Safety").tag(Category.Safety)
            }/*@END_MENU_TOKEN@*/
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
          let newInput = NewToolInput(condition: cond!, description: description, hourlyCost: Double(cost)!, location: loca, name: name, ownerId: ownerId, tags: [selectedCategory.rawValue])
          
          
          let group = DispatchGroup()
          //let new_id = addTool(input: newInput)
          group.enter()
          self.newTool.load(input: newInput, newImage: self.image) {
            group.leave()
            print("left")
          }
          //self.newTool.load(input: newInput, newImage: self.image)
          print("here")
          
          //self.showInApp = true
          group.notify(queue: .main) {
            print("dont adding tool")
            print("next page")
            self.showInApp = true
          }
          
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

func addTool(input: NewToolInput) -> Int {
  var newToolId = -1
  
  Network.shared.apollo.perform(mutation: AddToolMutation(tool: input)){ result in
    switch result {
    case .success(let graphQLResult):
      print("Success! Result: \(graphQLResult)")
      if let newTool = graphQLResult.data?.addTool {
        newToolId = newTool.id
      }
      
    case .failure(let error):
      print("Failure! Error: \(error)")
    }
  }
  return newToolId
}


enum Condition: String, CaseIterable, Identifiable {
    case new
    case great
    case good
    case fair
    case poor

    var id: String { self.rawValue }
}

enum Category: String, CaseIterable, Identifiable {
    case Camping
    case Cleaning
    case Hand_Tools
    case Gardening
    case Kitchen
    case Outdoor
    case Painting
    case Power_Tools
    case Safety
    case Miscellaneous

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


class NewTool: ObservableObject {

  @Published var data: Int
    
    init() {
      self.data = 0
    }

  func load(input: NewToolInput, newImage: UIImage, completed:  @escaping () -> ()) {
      Network.shared.apollo.clearCache()
      Network.shared.apollo.perform(mutation: AddToolMutation(tool: input)) { result in
        switch result {
        case .success(let graphQLResult):
          print("Success! Result: \(graphQLResult)")
          if let newTool = graphQLResult.data?.addTool {
            self.data = newTool.id
            
            do {
              //try AddImage(tool_id: newTool.id, addImage: newImage)
              let filename = save(image: newImage, name: String(newTool.id))
              print(filename!.utf8)
              print("Adding Image worked?")
            } catch {
                print("Adding Image Failed.")
            }
            completed()
          }
        case .failure(let error):
          print("Failure! Error: \(error)")
          print("completed")
          completed()
        }
      }
    
    }
  
}

var documentsUrl: URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
}

func save(image: UIImage, name: String) -> String? {
    let fileName = name
    let fileURL = documentsUrl.appendingPathComponent(fileName)
    print(fileURL)
    if let imageData = image.jpegData(compressionQuality: 1.0) {
       try? imageData.write(to: fileURL, options: .atomic)
       return fileName // ----> Save fileName
    }
    print("Error saving image")
    return nil
}
