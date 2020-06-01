//
//  ContentView.swift
//  NameFaceReminder
//
//  Created by slava bily on 17/5/20.
//  Copyright © 2020 slava bily. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var faces = Faces()
    @State private var face = Face(imageName: "", place: CodableMKPointAnnotation())
    @State private var images = [Image]()
    @State private var pickedImage: UIImage?
    @State private var showingImagePicker = false
    @State private var showingNamingView = false
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var showingPlaceDetails = false
 
    var body: some View {
         NavigationView {
            VStack {
                NavigationLink("", destination: NamingView(faces: faces, face: face, pickedImage: pickedImage), isActive: $showingNamingView)
                List {
                    ForEach(faces.items.sorted()) { item in
                        NavigationLink(destination:
                        DetailView(faces: self.faces,
                                   item: item,
                                   images: self.images,
                                   centerCoordinate: self.$centerCoordinate,
                                   showingPlaceDetails: self.$showingPlaceDetails)) {
                            if self.images.isEmpty == false {
                                self.images[self.faces.items.firstIndex(of: item)!]
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            }
                                    Text("\(item.imageName)")
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
                .onAppear(perform: loadImages) 
                  
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

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
