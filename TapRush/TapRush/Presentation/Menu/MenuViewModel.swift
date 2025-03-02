//
//  MenuViewModel.swift
//  TapRush
//
//  Created by Adam Mitro on 1/5/25.
//

import Foundation
import SwiftUICore
import SwiftUI

@MainActor
class MenuViewModel: ObservableObject {
    @Published var rocks: [Rock] = []
    @Published var miningSiteWidth: CGFloat = 0
    @Published var miningSiteHeight: CGFloat = 0
    @Published var gems: GemCount
    @Published var gold: GoldCount
    @Published var navPath = NavigationPath()
    @Published var inventory = Inventory(gemList: [])
    
    var navPathBinding: Binding<NavigationPath> {
            Binding(
                get: { self.navPath },
                set: { self.navPath = $0 }
            )
        }
    
    let miningMenuNavButtons: [MenuScreens] = [
        MenuScreens(name: Strings.map, destination: .map, icon: "map.fill", primaryColor: .outerSpace, secondaryColor: .roseGold),
        MenuScreens(name: Strings.inventory, destination: .inventory, icon: "shippingbox.fill", primaryColor: .outerSpace, secondaryColor: .roseGold),
        MenuScreens(name: Strings.store, destination: .store, icon: "storefront.fill", primaryColor: .outerSpace, secondaryColor: .roseGold),
        MenuScreens(name: Strings.pawnShop, destination: .pawnShop, icon: "dollarsign.circle.fill", primaryColor: .outerSpace, secondaryColor: .roseGold),
        MenuScreens(name: Strings.orders, destination: .orders, icon: "list.clipboard.fill", primaryColor: .outerSpace, secondaryColor: .roseGold),
        MenuScreens(name: Strings.awards, destination: .awards, icon: "trophy.fill", primaryColor: .outerSpace, secondaryColor: .roseGold)]
    
    init() {
        self.gems = CoreDataManager.shared.getGemCount()[0]
//        CoreDataManager.shared.deleteGemCount(gemCount: gemCount)
        self.gold = CoreDataManager.shared.getGoldCount()[0]
        print(self.gold.count)
        print("self.gold.count")
        
        // Get other items stored in CoreData TBD
        
        inventory = InventoryHelpers().updateInventoryList(gems: gems, gold: gold)
    }
    
    func delete(_ gemCount: GemCount) {
        let existingGemCount = CoreDataManager.shared.getGemCountById(id: gemCount.objectID)
        if let existingGemCount = existingGemCount {
            CoreDataManager.shared.deleteGemCount(gemCount: existingGemCount)
        }
    }
    
    func save() {
        let gemCounts = GemCount(context: CoreDataManager.shared.viewContext)
        let goldCount = GoldCount(context: CoreDataManager.shared.viewContext)
        
        gemCounts.common = gems.common
        gemCounts.uncommon = gems.uncommon
        gemCounts.rare = gems.rare
        gemCounts.legendary = gems.legendary
        gemCounts.mythical = gems.mythical
        
        goldCount.count = gold.count
        
        inventory = InventoryHelpers().updateInventoryList(gems: gems, gold: gold)
        
        CoreDataManager.shared.save()
    }
    
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
    
    func updateGemCount(gemType: GemType, amount: Int) {
        if gemType == .common {
            gems.common += amount
        } else if gemType == .uncommon {
            gems.uncommon += amount
        } else if gemType == .rare {
            gems.rare += amount
        } else if gemType == .legendary {
            gems.legendary += amount
        } else if gemType == .mythical {
            gems.mythical += amount
        }
    }

    @objc func updateStateIndex(index: Int) {
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
