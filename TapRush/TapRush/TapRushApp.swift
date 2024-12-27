//
//  TapRushApp.swift
//  TapRush
//
//  Created by Adam Mitro on 12/13/24.
//

import SwiftUI
import SwiftData

@main
struct TapRushApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Count.self)
    }
}
