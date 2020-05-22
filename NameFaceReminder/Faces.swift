//
//  Faces.swift
//  NameFaceReminder
//
//  Created by slava bily on 21/5/20.
//  Copyright © 2020 slava bily. All rights reserved.
//

import Foundation

class Faces: ObservableObject {
    @Published var items = [Face]() {
        didSet {
           save(model: items, fileName: "model")
        }
    }
    
    init() {
        let url = self.getDocumentsDirectory().appendingPathComponent("model")
        if let input = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Face].self, from: input) {
                self.items = decoded
                return
            }
        }
        print("Model is empty")
        self.items = []
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func save(model: [Face], fileName: String) {
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
