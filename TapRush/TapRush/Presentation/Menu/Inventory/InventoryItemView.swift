//
//  InventoryItemView.swift
//  TapRush
//
//  Created by Adam Mitro on 2/20/25.
//

import SwiftUI

struct InventoryItemView: View {
    @Binding var gemItem: GemItem
    
    var body: some View {
        ZStack {
            Image(gemItem.gem.sprites[0])
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
                    Text("x\(gemItem.itemCount)")
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
    @Previewable @State var item = GemItem(itemCount: 2, itemDescription: "", gemType: .common)
    
    InventoryItemView(gemItem: $item)
}
