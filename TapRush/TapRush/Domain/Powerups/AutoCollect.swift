//
//  AutoCollect.swift
//  TapRush
//
//  Created by Adam Mitro on 6/2/25.
//

import Foundation

class AutoCollect: Powerup {
    var count: Int = 0
    var isActive: Bool = false
    var name = "Auto Collect"
    
    func decrementCount() {
        self.count -= 1
    }
    
    func incrementCount(addToCount: Int) {
        self.count += addToCount
    }
}
