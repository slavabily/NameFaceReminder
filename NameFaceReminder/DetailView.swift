//
//  DetailView.swift
//  NameFaceReminder
//
//  Created by slava bily on 27/5/20.
//  Copyright © 2020 slava bily. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var faces: Faces
    var item: Face
    var images: [Image]
    
    var body: some View {
        Group {
            if self.images.isEmpty == false {
                self.images[self.faces.items.firstIndex(of: self.item)!]
                    .resizable()
                    .scaledToFit()
            }
        }
        .navigationBarTitle("\(self.item.imageName)", displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var faces = Faces()
    static var item = Face(imageName: "")
    static var images = [Image]()
    
    static var previews: some View {
        DetailView(faces: faces, item: item, images: images)
    }
}
