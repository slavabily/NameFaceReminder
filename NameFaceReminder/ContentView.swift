//
//  ContentView.swift
//  NameFaceReminder
//
//  Created by slava bily on 17/5/20.
//  Copyright © 2020 slava bily. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var faces = Faces()
    @State private var images = [Image]()
    @State private var pickedImage: UIImage?
    @State private var showingImagePicker = false
    @State private var showingNamingView = false
    
    var body: some View {
         NavigationView {
            VStack {
                NavigationLink("", destination: NamingView(faces: $faces, pickedImage: $pickedImage), isActive: $showingNamingView)
                List {
                    ForEach(faces.items.sorted()) { item in
                        NavigationLink(destination: NamingView(faces: self.$faces, pickedImage: self.$pickedImage)) {
                            if self.images.isEmpty == false {
                                self.images[self.faces.items.firstIndex(of: item)!]
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            }
                            
                            Text(item.imageName)
                                .onAppear() {
                                    self.loadImages()
                            }
                            
                        }
                    
                    }
                }
                .navigationBarTitle("NameFaceReminder")
                .navigationBarItems(trailing: Button(action: {
                    self.showingImagePicker = true
                }, label: {
                    Image(systemName: "plus")
                }))
                    .sheet(isPresented: $showingImagePicker, onDismiss: nameTheImage) {
                        ImagePicker(image: self.$pickedImage)
                }
            }
            .onAppear(perform: loadData)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let fileName = getDocumentsDirectory().appendingPathComponent("Saved")
        
        do {
            let data = try Data(contentsOf: fileName)
            faces = try JSONDecoder().decode(Faces.self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    func loadImages() {
        for item in faces.items {
            let url = getDocumentsDirectory().appendingPathComponent(item.imageName)
            do {
                let jpegData = try Data(contentsOf: url)
                if let uiImage = UIImage(data: jpegData) {
                  let image = Image(uiImage: uiImage)
                    images.append(image)
                    print(images)
                } else {
                    print("No UIImages converted")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func nameTheImage() {
        guard pickedImage != nil else { return }
        print("Image selected")
        self.showingNamingView = true
    }
 }
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
