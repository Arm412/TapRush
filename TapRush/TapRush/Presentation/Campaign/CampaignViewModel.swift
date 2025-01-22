//
//  CampaignViewModel.swift
//  TapRush
//
//  Created by Adam Mitro on 1/5/25.
//

import Foundation
import SwiftUICore

@MainActor
class CampaignViewModel: ObservableObject {
    @Published var rocks: [Rock] = []
    @Published var miningSiteWidth: CGFloat = 0
    @Published var miningSiteHeight: CGFloat = 0
    
    var stateUpdateTimer: Timer?
    
    func initRocks(geo: GeometryProxy) {
        miningSiteWidth = geo.size.width
        miningSiteHeight = geo.size.height
        
        for i in 1...10 {
            createRock()
        }
    }
    
    func createRock() {
        var validCoordinate = false
        let screenWidth = miningSiteWidth
        let widthLimit = screenWidth - 100
        let screenHeight = miningSiteHeight
        let heightLimit = screenHeight - 175
        var rockX = 0
        var rockY = 0
        
        while !validCoordinate {
            rockX = Int.random(in: 50 ..< Int(widthLimit))
            rockY = Int.random(in: 50 ..< Int(heightLimit))
            var reset = false
            for rock in rocks {
                let rangeX = (rock.position.x - 75) ..< (rock.position.x + 75)
                let rangeY = (rock.position.y - 75) ..< (rock.position.y + 75)
                if rangeX.contains(CGFloat(rockX)) && rangeY.contains(CGFloat(rockY)) {
                    reset = true
                    break
                }
            }
            if !reset {
                validCoordinate = true
            }
        }
        print("Add rock \(rockX), \(rockY)")
        rocks.append(Rock(id: UUID(), position: CGPoint(x: rockX, y: rockY), rockType: .beginner))
    }
    
    func startStateUpdateTimer(index: Int) {
        stateUpdateTimer?.invalidate()
        
        stateUpdateTimer = Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { [weak self] _ in
            Task { [weak self] in
                await self?.updateStateIndex(index: index)
            }
        }
    }

    @objc func updateStateIndex(index: Int) {
        print("rocks[index].stateIndex: \(rocks[index].stateIndex)")
        if rocks[index].stateIndex == 8 {
            stateUpdateTimer?.invalidate()
            stateUpdateTimer = nil
            
            rocks[index].isDepleted = true
            rocks[index].determineGem()
            
            if !rocks[index].hasGem {
                rocks.remove(at: index)
                createRock()
            }
            
            return
        }
        
        rocks[index].stateIndex += 1
    }
}
