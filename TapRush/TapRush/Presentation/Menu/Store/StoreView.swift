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
                                
                                // Items
                                StoreHeaderView(headerName: "Items")
                                
                                // Powerups
                                StoreHeaderView(headerName: "Powerups")
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
        .padding(.top, 15)
    }
}

#Preview {
    var viewModel = MenuViewModel()
    
    StoreView()
        .environmentObject(viewModel)
}
