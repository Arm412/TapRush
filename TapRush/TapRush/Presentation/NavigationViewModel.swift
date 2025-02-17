//
//  NavigationViewModel.swift
//  TapRush
//
//  Created by Adam Mitro on 2/16/25.
//

import Foundation
import SwiftUI

class NavigationViewModel: ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    func navigateTo(screen: Screen) {
        navigationPath.append(screen)
    }
    
    func resetNavigation() {
        navigationPath = NavigationPath()
    }
    
    func removeLastScreen() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }
}
