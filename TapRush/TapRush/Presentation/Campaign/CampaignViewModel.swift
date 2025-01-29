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
    let campaignDashboardNavButtons: [CampaignScreens] = [
        CampaignScreens(name: "Map", destination: AnyView(MapView()), icon: "map.fill", primaryColor: .outerSpace, secondaryColor: .roseGold),
        CampaignScreens(name: "Inventory", destination: AnyView(InventoryView()), icon: "shippingbox.fill", primaryColor: .outerSpace, secondaryColor: .roseGold),
        CampaignScreens(name: "Store", destination: AnyView(StoreView()), icon: "storefront.fill", primaryColor: .outerSpace, secondaryColor: .roseGold),
        CampaignScreens(name: "Pawn Shop", destination: AnyView(PawnShopView()), icon: "dollarsign.circle.fill", primaryColor: .outerSpace, secondaryColor: .roseGold),
        CampaignScreens(name: "Orders", destination: AnyView(OrdersView()), icon: "list.clipboard.fill", primaryColor: .outerSpace, secondaryColor: .roseGold),
        CampaignScreens(name: "Awards", destination: AnyView(AwardsView()), icon: "trophy.fill", primaryColor: .outerSpace, secondaryColor: .roseGold)]
    
    func initRocks(geo: GeometryProxy) {
        miningSiteWidth = geo.size.width
        miningSiteHeight = geo.size.height
        
        while rocks.count != 10 {
            rocks.append(createRock())
        } 
    }
    
    func createRock() -> Rock {
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
        return Rock(id: UUID(), position: CGPoint(x: rockX, y: rockY), rockType: .beginner)
    }
    
    func startStateUpdateTimer(index: Int) {
        rocks[index].animationTimer?.invalidate()
        
        rocks[index].determineGem()
        
        rocks[index].animationTimer = Timer.scheduledTimer(withTimeInterval: 1/10, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateStateIndex(index: index)
            }
        }
    }

    @objc func updateStateIndex(index: Int) {
        print("rocks[\(index)].dust.spriteIndex: \(rocks[index].dust.spriteIndex)")
        if rocks[index].dust.spriteIndex == rocks[index].dust.dustCloudSprites.count - 1 {
            rocks[index].animationTimer?.invalidate()
            rocks[index].animationTimer = nil
            
            rocks[index].dustSettled = true
            if (!rocks[index].hasGem) {
                rocks[index] = createRock()
            }
        } else {
            rocks[index].dust.spriteIndex += 1
        }
    }
}
