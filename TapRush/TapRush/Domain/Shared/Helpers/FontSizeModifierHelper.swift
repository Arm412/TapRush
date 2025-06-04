//
//  FontSizeModifierHelper.swift
//  TapRush
//
//  Created by Adam Mitro on 2/7/25.
//

import Foundation
import SwiftUI

struct FontSizeModifierHelper: ViewModifier {
    var screenWidth: CGFloat
    var customFontName: String?
    
    // Calculate font size based on screen width
    func body(content: Content) -> some View {
        let fontSize: CGFloat
        
        // Example logic: Adjust font size based on screen width
        if screenWidth <= 375 {  // Small devices (like iPhone SE)
            fontSize = 20
        } else if screenWidth <= 600 { // Medium devices (like iPhone 8 Plus)
            fontSize = 30
        } else { // Larger devices (like iPad, iPhone 12 Pro Max)
            fontSize = 40
        }
        
        if let fontName = customFontName {
            return content.font(.custom(fontName, size: fontSize))
        }
        return content
            .font(.system(size: fontSize))
    }
}

extension View {
    func adaptiveFontSize(customFontName: String) -> some View {
        self.modifier(FontSizeModifierHelper(screenWidth: UIScreen.main.bounds.width, customFontName: customFontName))
    }
    
    func adaptiveFontSize() -> some View {
        self.modifier(FontSizeModifierHelper(screenWidth: UIScreen.main.bounds.width))
    }
}
