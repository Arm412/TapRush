//
//  StoreView.swift
//  TapRush
//
//  Created by Adam Mitro on 1/23/25.
//

import SwiftUI

struct StoreView: View {
    @EnvironmentObject var menuVM: MenuViewModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    TopNavBarView(foregroundColor: .peachOrange, title: Strings.store)
                    VStack {
                        HStack {
                            Image("gold")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            Text("\(menuVM.inventory.goldCount)")
                                .font(.system(size: 25))
                                .foregroundStyle(.white)
                                .padding(.leading, 15)
                        }
                        ScrollView {
                            VStack {
                                // Upgrades
                                StoreHeaderView(headerName: "Upgrades")
                                StoreItemView(goldCost: 50, itemName: "Pickaxe")
                                
                                StoreItemView(goldCost: 50, itemName: "Inventory")
                                
                                // Items
                                StoreHeaderView(headerName: "Items")
                                StoreItemView(goldCost: 50, itemName: "Gold Detector")
                                
                                StoreItemView(goldCost: 50, itemName: "Magnifying Glass")
                                StoreItemView(goldCost: 50, itemName: "4 Leaf Clover")
                                
                                // Powerups
                                StoreHeaderView(headerName: "Powerups")
                                StoreItemView(goldCost: 50, itemName: "Auto Collect")
                                StoreItemView(goldCost: 50, itemName: "Power Strike")
                                
                                StoreItemView(goldCost: 50, itemName: "Blast Off")
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.outerSpace)
    }
}

struct StoreHeaderView: View {
    let headerName: String
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(.peachOrange)
                .frame(height: 2)
                .frame(maxWidth: .infinity)
            Text(headerName)
                .font(.custom("Audiowide-Regular", size: 17))
                .foregroundStyle(.peachOrange)
            Rectangle()
                .fill(.peachOrange)
                .frame(height: 2)
                .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 15)
    }
}

struct StoreItemView: View {
    var goldCost: Int
    var itemName: String
    
    var body: some View {
        HStack {
            Image(systemName: "questionmark")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 45, height: 45)
                .padding()
                .border(.gray, width: 2)
            Text(itemName)
                .frame(width: 150, height: 75, alignment: .leading)
                .foregroundStyle(.peachOrange)
            HStack {
                Text("\(goldCost)x")
                    .frame(height: 75, alignment: .leading)
                    .foregroundStyle(.peachOrange)
                Image("gold")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 10)
            }
        }
        .border(.gray, width: 2)
    }
}

#Preview {
    var viewModel = MenuViewModel()
    
    StoreView()
        .environmentObject(viewModel)
}
