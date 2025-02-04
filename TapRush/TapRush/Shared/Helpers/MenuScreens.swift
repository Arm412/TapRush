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
    var destination: AnyView
    var icon: String
    var primaryColor: Color
    var secondaryColor: Color
    
    init(name: String, destination: AnyView, icon: String, primaryColor: Color, secondaryColor: Color) {
        self.id = UUID()
        self.name = name
        self.destination = destination
        self.icon = icon
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
}
