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
    
    var stateUpdateTimer: Timer?
    
    func initRocks(geo: GeometryProxy) {
        var validCoordinate = false
        let screenWidth = geo.size.width
        let widthLimit = screenWidth - 100
        let screenHeight = geo.size.height
        let heightLimit = screenHeight - 100
        var rockX = 0
        var rockY = 0
        
        for i in 1...10 {
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
            validCoordinate = false
        }
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
            return
        }
        
        rocks[index].stateIndex += 1
    }
}
