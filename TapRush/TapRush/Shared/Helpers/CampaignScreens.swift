//
//  CampaignScreens.swift
//  TapRush
//
//  Created by Adam Mitro on 1/24/25.
//

import Foundation
import SwiftUICore

struct CampaignScreens: Identifiable {
    var id: UUID
    
    var name: String
    var destination: any View
    var icon: Image
    var primaryColor: Color
    var secondaryColor: Color
    
    init(name: String, destination: any View, icon: Image, primaryColor: Color, secondaryColor: Color) {
        self.id = UUID()
        self.name = name
        self.destination = destination
        self.icon = icon
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
}
