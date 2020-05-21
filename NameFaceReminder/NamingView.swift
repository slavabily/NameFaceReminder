//
//  NamingView.swift
//  NameFaceReminder
//
//  Created by slava bily on 20/5/20.
//  Copyright © 2020 slava bily. All rights reserved.
//

import SwiftUI

struct NamingView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var pickedImage: UIImage?
    @State private var photoName = ""
    @State private var photoNameUUID: UUID?
 
    var body: some View {
        Form {
            Section(header: Text("Please, enter photo's name")) {
                TextField("Name", text: $photoName) {
                    if self.pickedImage != nil {
                        self.record(image: self.pickedImage!, fileName: self.photoName)
                        self.photoNameUUID = UUID(uuidString: self.photoName)
                        if self.photoNameUUID != nil {
                            self.save(model: Face(id: self.photoNameUUID!, imageName: self.photoName), fileName: "model")
                        } else {
                            print("UUID is not generated!")
                        }
                    } else {
                        // alert of unseccessful image selection and then to dismiss the view
                    }
                    
                }
            }
        }
        .navigationBarTitle("Naming and Saving", displayMode: .inline)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func record(image: UIImage, fileName: String) {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            do {
               try jpegData.write(to: url, options: [.atomicWrite, .completeFileProtection])
                print("Jpeg data is saved")
                self.presentationMode.wrappedValue.dismiss()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func save(model: Face, fileName: String) {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        let encoder = JSONEncoder()
        if let modelData = try? encoder.encode(model) {
            do {
                try modelData.write(to: url, options: [.atomicWrite, .completeFileProtection])
                print("Model data is saved")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct NamingView_Previews: PreviewProvider {
    @State static var pickedImage: UIImage?
    static var previews: some View {
        NamingView(pickedImage: $pickedImage)
    }
}

 
