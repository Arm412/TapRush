//
//  MenuScreens.swift
//  TapRush
//
//  Created by Adam Mitro on 1/24/25.
//

import Foundation
import SwiftUICore

struct MenuScreens: Identifiable {
    var id: UUID
    var name: String
    var destination: Screen
    var icon: String
    var primaryColor: Color
    var secondaryColor: Color
    
    init(name: String, destination: Screen, icon: String, primaryColor: Color, secondaryColor: Color) {
        self.id = UUID()
        self.name = name
        self.destination = destination
        self.icon = icon
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
}

enum Screen: Hashable {
    case dashboard
    case mining
    case miningMenu
    case awards
    case inventory
    case map
    case orders
    case pawnShop
    case store
}
