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
            if gemTypeName != .none {
                let gemCount = (gems.value(forKey: gemTypeName.rawValue) ?? 0) as! Int64
                let gemInvItem = GemItem(itemIcon: GemManager().getGemNames(for: gemTypeName)[0], itemCount: gemCount, itemName: gemTypeName.rawValue.capitalized, itemDescription: "", gemType: gemTypeName)
                inventory.gemList.append(gemInvItem)
            }
        }
        
        // Add gold to inventory
        inventory.goldCount = gold.count
        
        return inventory
    }
}

protocol InventoryItem: Hashable {
    var itemIcon: String { get }
    var itemCount: Int64 { get }
    var itemName: String { get }
    var itemDescription: String { get }
}

struct GemItem: Hashable {
    var itemIcon: String = ""
    var itemCount: Int64 = 0
    var itemName: String = ""
    var itemDescription: String = ""
    var gemType: GemType = .none
    var gemToGoldRatio: Double = 0
    
    init(itemIcon: String, itemCount: Int64, itemName: String, itemDescription: String, gemType: GemType) {
        self.itemIcon = itemIcon
        self.itemCount = itemCount
        self.itemName = itemName
        self.itemDescription = itemDescription
        self.gemType = gemType
        
        // Set the gem to gold conversion ratio based on gem type
        if gemType == .common {
            gemToGoldRatio = 0.1
        } else if gemType == .uncommon {
            gemToGoldRatio = 0.2
        } else if gemType == .rare {
            gemToGoldRatio = 1
        } else if gemType == .legendary {
            gemToGoldRatio = 5
        } else if gemType == .mythical {
            gemToGoldRatio = 10
        }
    }
}

struct Inventory {
    var gemList: [GemItem]
    var goldCount: Int64 = 0
    
    init(gemList: [GemItem]) {
        self.gemList = gemList
    }
    
    func getTotalInventoryCount() -> Int64 {
        var itemCount: Int64 = 0
        
        for item in gemList {
            itemCount += item.itemCount
        }
        return itemCount
    }
}
