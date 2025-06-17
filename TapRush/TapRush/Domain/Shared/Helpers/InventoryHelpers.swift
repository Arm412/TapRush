//
//  InventoryHelpers.swift
//  TapRush
//
//  Created by Adam Mitro on 2/19/25.
//

import Foundation

class InventoryHelpers {
    func updateInventoryList(gems: GemCount, gold: GoldCount) -> Inventory {
        var inventory = Inventory(gemList: [])
        
        // Add gem to inventory
        for gemTypeName in GemType.allCases {
            let gemCount = (gems.value(forKey: gemTypeName.rawValue) ?? 0) as! Int
            let gemInvItem = GemItem(itemCount: gemCount, itemDescription: "", gemType: gemTypeName)
            inventory.gemList.append(gemInvItem)
        }
        
        // Add gold to inventory
        inventory.goldCount = gold.count
        
        return inventory
    }
}

protocol InventoryItem: Hashable {
    var itemIcon: String { get }
    var itemCount: Int { get }
    var itemName: String { get }
    var itemDescription: String { get }
}

struct GemItem: Identifiable {
    var id: UUID = UUID()
    var itemCount: Int = 0
    var itemDescription: String = ""
    var gem: Gem
    var minimumGemIncrement: Int = 0
    var goldPerIncrement: Int = 0
    
    init(itemCount: Int, itemDescription: String, gemType: GemType) {
        self.itemCount = itemCount
        self.itemDescription = itemDescription

        self.gem = Gem(type: gemType)
        
        // Set the gem to gold conversion ratio based on gem type
        if gemType == .common {
            minimumGemIncrement = 10
            goldPerIncrement = 1
        } else if gemType == .uncommon {
            minimumGemIncrement = 5
            goldPerIncrement = 1
        } else if gemType == .rare {
            minimumGemIncrement = 1
            goldPerIncrement = 1
        } else if gemType == .legendary {
            minimumGemIncrement = 1
            goldPerIncrement = 5
        } else if gemType == .mythical {
            minimumGemIncrement = 1
            goldPerIncrement = 10
        }
    }
}

struct Inventory {
    var gemList: [GemItem]
    var goldCount: Int = 0
    
    init(gemList: [GemItem]) {
        self.gemList = gemList
    }
    
    func getTotalInventoryCount() -> Int {
        var itemCount: Int = 0
        
        for item in gemList {
            itemCount += item.itemCount
        }
        return itemCount
    }
}
