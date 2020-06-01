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
    var images: [Image]
    
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var showingPlaceDetails: Bool

    var body: some View {
        VStack {
            if self.images.isEmpty == false {
                GeometryReader { (geo) in
                    self.images[self.faces.items.firstIndex(of: self.item)!]
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                        .frame(width: geo.size.width)
                }
            }
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: item.place, showingPlaceDetails: $showingPlaceDetails)
        }
        .navigationBarTitle("\(self.item.imageName)", displayMode: .inline)
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var faces = Faces()
//    static var item = Face(imageName: "")
//    static var images = [Image]()
//
//    static var previews: some View {
//        DetailView(faces: faces, item: item, images: images)
//    }
//}
