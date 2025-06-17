//
//  PowerStrike.swift
//  TapRush
//
//  Created by Adam Mitro on 6/2/25.
//

import Foundation

class PowerStrike: Powerup {
    var count: Int = 0
    var isActive: Bool = false
    var name = "Power Strike"
    
    func decrementCount() {
        self.count -= 1
    }
    
    func incrementCount(addToCount: Int) {
        self.count += addToCount
    }
}
