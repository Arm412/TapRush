//
//  InventoryHelpers.swift
//  TapRush
//
//  Created by Adam Mitro on 2/19/25.
//

import Foundation

class InventoryHelpers {
    func createInventoryList(gems: GemCount, gold: GoldCount) -> Inventory {
        var inventory = Inventory(itemList: [])
        
        // Add gem to inventory
        for gemTypeName in GemType.allCases {
            if gemTypeName != .none {
                let gemCount = (gems.value(forKey: gemTypeName.rawValue) ?? 0) as! Int64
                let gemInvItem = InventoryItem(itemIcon: GemManager().getGemNames(for: gemTypeName)[0], itemCount: gemCount, itemName: gemTypeName.rawValue.capitalized, itemDescription: "")
                inventory.itemList.append(gemInvItem)
            }
        }
        
        // Add gold to inventory
        inventory.goldCount = gold.count
        
        return inventory
    }
}

struct InventoryItem: Hashable {
    var itemIcon: String
    var itemCount: Int64
    var itemName: String
    var itemDescription: String
    
    init(itemIcon: String, itemCount: Int64, itemName: String, itemDescription: String) {
        self.itemIcon = itemIcon
        self.itemCount = itemCount
        self.itemName = itemName
        self.itemDescription = itemDescription
    }
}

struct Inventory {
    var itemList: [InventoryItem]
    var goldCount: Int64 = 0
    
    init(itemList: [InventoryItem]) {
        self.itemList = itemList
    }
    
    func getTotalInventoryCount() -> Int64 {
        var itemCount: Int64 = 0
        
        for item in itemList {
            itemCount += item.itemCount
        }
        return itemCount
    }
}
