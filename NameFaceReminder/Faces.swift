//
//  Faces.swift
//  NameFaceReminder
//
//  Created by slava bily on 21/5/20.
//  Copyright © 2020 slava bily. All rights reserved.
//

import Foundation

class Faces: ObservableObject {
    @Published var faces = [Face]() {
        didSet {
            
        }
    }
}
