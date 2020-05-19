//
//  Face.swift
//  NameFaceReminder
//
//  Created by slava bily on 18/5/20.
//  Copyright © 2020 slava bily. All rights reserved.
//

import Foundation

struct Face: Codable, Identifiable, Comparable {
    var id: UUID
    var name: String
    var image: Data
    
    static func < (lhs: Face, rhs: Face) -> Bool {
        lhs.name < rhs.name
    }
    
     
    
    
}
