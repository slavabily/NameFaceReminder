//
//  NamingView.swift
//  NameFaceReminder
//
//  Created by slava bily on 20/5/20.
//  Copyright © 2020 slava bily. All rights reserved.
//

import SwiftUI

struct NamingView: View {
    var faces: Faces
    var pickedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    @State private var photoName = ""

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Please, enter photo's name")) {
                    TextField("Name", text: $photoName)
                }
                Image(uiImage: pickedImage ?? UIImage())
                .resizable()
                .scaledToFit()
            }
        }
        .navigationBarTitle("Naming and Saving", displayMode: .inline)
        .navigationBarItems(trailing: Button("Save") {
            self.record(image: self.pickedImage ?? UIImage(), fileName: self.photoName)
            
            if self.photoName != "" {
                let item = Face(imageName: self.photoName)
                self.faces.items.append(item)
                self.saveData()
                self.presentationMode.wrappedValue.dismiss()
            } else {
                print("Problem with saving items...")
            }
        })
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveData() {
        do {
            let fileName = getDocumentsDirectory().appendingPathComponent("Saved")
            let data = try JSONEncoder().encode(self.faces)
            try data.write(to: fileName, options: [.atomic, .completeFileProtection])
         } catch {
            print("Unable to save data")
        }
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
}

struct NamingView_Previews: PreviewProvider {
    @State static var pickedImage: UIImage?
    @State static var faces = Faces()
    
    static var previews: some View {
        NamingView(faces: faces, pickedImage: pickedImage)
    }
}

 
