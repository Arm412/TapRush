//
//  MenuViewModel.swift
//  TapRush
//
//  Created by Adam Mitro on 1/5/25.
//

import Foundation
import SwiftUICore
import SwiftUI
import CoreData

@MainActor
class MenuViewModel: ObservableObject {
    @Published var rocks: [Rock] = []
    @Published var miningSiteWidth: CGFloat = 0
    @Published var miningSiteHeight: CGFloat = 0
    @Published var gems: GemCount
    @Published var gold: GoldCount
    @Published var navPath = NavigationPath()
    @Published var inventory = Inventory(gemList: [])
    @Published var coordinates: [[Int]] = [[100, 100], [200, 200], [300, 300]]
    @Published var activeMineName: String?
    @Published var activeMineIndex = 0
    @Published var savedMine: Mine? = nil
    @Published var mineList: [Mine] = MineHelpers.allMines
    
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
        
        self.activeMineName = CoreDataManager.shared.getSavedCurrentMine()?.mineName
        
        if let savedMineIndex = mineList.firstIndex(where: { $0.name.rawValue == activeMineName }) {
            print("Found last visited mine: \(mineList[savedMineIndex].name)")
            mineList[savedMineIndex].isActive = true
            activeMineIndex = savedMineIndex
        } else {
            // Could not find mine in coredata, use the default mine and set it as active.
            mineList[0].isActive = true
            
            print("Could not find previous mine. Setting default mine.")
        }
        
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
    
    func saveGems() {
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
    
    func saveCurrentMine() {
        let context = CoreDataManager.shared.viewContext
        let request: NSFetchRequest<CurrentMine> = CurrentMine.fetchRequest()
        
        do {
            let results = try context.fetch(request)
            
            var currentMineToSave: CurrentMine
            if let existingMine = results.first {
                currentMineToSave = existingMine
            } else {
                currentMineToSave = CurrentMine(context: context)
            }
            
            currentMineToSave.mineName = mineList[activeMineIndex].name.rawValue
            print("Saved current mine to CoreData: \(currentMineToSave.mineName ?? "")")
            
            CoreDataManager.shared.save()
            
        } catch {
            print("Failed to fetch CurrentMine: \(error)")
        }
    }
    
    func sellGems(soldGems: SoldGemCounts, aqcuiredGold: Int) {
        gems.common -= soldGems.common.count
        gems.uncommon -= soldGems.uncommon.count
        gems.rare -= soldGems.rare.count
        gems.legendary -= soldGems.legendary.count
        gems.mythical -= soldGems.mythical.count
        
        gold.count += aqcuiredGold
        
        self.saveGems()
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
    
    func updateGemCount(gem: Gem, amount: Int) {
        if gem.type == .common {
            gems.common += amount
        } else if gem.type == .uncommon {
            gems.uncommon += amount
        } else if gem.type == .rare {
            gems.rare += amount
        } else if gem.type == .legendary {
            gems.legendary += amount
        } else if gem.type == .mythical {
            gems.mythical += amount
        }
    }

    @objc func updateStateIndex(index: Int) {
        if rocks[index].dust.spriteIndex == rocks[index].dust.dustCloudSprites.count - 1 {
            rocks[index].animationTimer?.invalidate()
            rocks[index].animationTimer = nil
            
            rocks[index].dustSettled = true
            if (rocks[index].gem == nil) {
                rocks[index] = createRock()
            }
        } else {
            rocks[index].dust.spriteIndex += 1
        }
    }
}
