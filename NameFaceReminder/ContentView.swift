//
//  ContentView.swift
//  NameFaceReminder
//
//  Created by slava bily on 17/5/20.
//  Copyright © 2020 slava bily. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var pickedImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        NavigationView {
            List {
                Text("Hello, World!")
            }
            .navigationBarTitle("NameFaceReminder")
            .navigationBarItems(trailing: Button(action: {
                self.showingImagePicker = true
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: self.$pickedImage)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
