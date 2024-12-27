//
//  Count.swift
//  TapRush
//
//  Created by Adam Mitro on 12/17/24.
//

import Foundation
import SwiftData

@Model
class Count: Identifiable {
    @Attribute(.unique) var id: String
    var count: Int
    
    init(count: Int) {
        self.id = UUID().uuidString
        self.count = count
    }
}
