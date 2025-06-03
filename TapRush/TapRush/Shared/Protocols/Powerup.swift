//
//  Powerup.swift
//  TapRush
//
//  Created by Adam Mitro on 6/1/25.
//

import Foundation

protocol Powerup {
    var count: Int { get }
    var isActive: Bool { get set }
    
    func decrementCount()
    func incrementCount(addToCount: Int)
}
