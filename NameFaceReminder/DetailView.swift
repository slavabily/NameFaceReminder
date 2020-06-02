//
//  DetailView.swift
//  NameFaceReminder
//
//  Created by slava bily on 27/5/20.
//  Copyright © 2020 slava bily. All rights reserved.
//

import SwiftUI
import MapKit

struct DetailView: View {
    var faces: Faces
    var item: Face

    var body: some View {
        VStack {
            GeometryReader { (geo) in
                self.loadImage(self.item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width)
            }
            MapView(selectedPlace: item.place)
        }
        .navigationBarTitle("\(self.item.imageName)", displayMode: .inline)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadImage(_ name: String) -> Image {
        
        let url = getDocumentsDirectory().appendingPathComponent(name)
        var i = Image(name)
        do {
            let jpegData = try Data(contentsOf: url)
            if let uiImage = UIImage(data: jpegData) {
                let image = Image(uiImage: uiImage)
                i = image
            } else {
                print("No UIImages converted")
            }
        } catch {
            print(error.localizedDescription)
        }
        return i
    }
}

struct DetailView_Previews: PreviewProvider {
    static var faces = Faces()
    static var item = Face(imageName: "1", place: CodableMKPointAnnotation())
    static var images = [Image]()

    static var previews: some View {
        DetailView(faces: faces, item: item)
    }
}
