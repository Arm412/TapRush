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
//        var inventoryList: [String: Int64] = [:]
        
        // Add gem to inventory
        for gemTypeName in GemType.allCases {
            if gemTypeName != .none {
                let gemCount = (gems.value(forKey: gemTypeName.rawValue) ?? 0) as! Int64
//                inventoryList[gemTypeName.rawValue] = gemCount
                let gemInvItem = InventoryItem(itemIcon: GemManager().getGemNames(for: gemTypeName)[0], itemCount: gemCount, itemName: gemTypeName.rawValue.capitalized, itemDescription: "")
                inventory.itemList.append(gemInvItem)
            }
        }
        
        // Add gold to inventory
        let goldInvItem = InventoryItem(itemIcon: GemManager().getGemNames(for: .common)[0], itemCount: gold.count, itemName: "Gold", itemDescription: "")
        inventory.itemList.append(goldInvItem)
//        inventoryList["gold"] = Int64(gold.count)
        
        return inventory
    }
}

struct InventoryItem {
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
    
    init(itemList: [InventoryItem]) {
        self.itemList = itemList
    }
}
