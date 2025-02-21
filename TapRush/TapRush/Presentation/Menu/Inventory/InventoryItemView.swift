//
//  InventoryItemView.swift
//  TapRush
//
//  Created by Adam Mitro on 2/20/25.
//

import SwiftUI

struct InventoryItemView: View {
    var body: some View {
        ZStack {
            Image("purpEmerald1")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Image(systemName: "trash.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .offset(x: 40, y: -40)
                .foregroundStyle(.shipCove)
            
            VStack {
                Spacer()
                HStack {
                    Text("x10000")
                        .font(.custom("Roboto", size: 20))
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                        .foregroundStyle(.peachOrange)
                    Spacer()
                }
            }
        }
        .frame(width: 110, height: 120)
    }
}

#Preview {
    InventoryItemView()
}
