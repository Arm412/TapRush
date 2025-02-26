//
//  InventoryItemView.swift
//  TapRush
//
//  Created by Adam Mitro on 2/20/25.
//

import SwiftUI

struct InventoryItemView: View {
    @Binding var inventoryItem: InventoryItem
    
    var body: some View {
        ZStack {
            Image(inventoryItem.itemIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
            
            Image(systemName: "trash.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .offset(x: 40, y: -40)
                .foregroundStyle(.shipCove)
            
            VStack {
                Spacer()
                HStack {
                    Text("x\(inventoryItem.itemCount)")
                        .font(.custom("Roboto", size: 20))
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                        .foregroundStyle(.white)
                    Spacer()
                }
            }
        }
        .frame(width: 110, height: 120)
    }
}

#Preview {
    @Previewable @State var item = InventoryItem(itemIcon: "", itemCount: 2, itemName: "", itemDescription: "")
    
    InventoryItemView(inventoryItem: $item)
}
