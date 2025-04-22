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
                        VStack {
                            HStack {
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(height: 2)
                                    .frame(maxWidth: .infinity)
                                Text("Upgrades")
                                    .font(.custom("Audiowide-Regular", size: 17))
                                    .foregroundStyle(.peachOrange)
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(height: 2)
                                    .frame(maxWidth: .infinity)
                            }
                            
                            HStack {
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(height: 2)
                                    .frame(maxWidth: .infinity)
                                Text("Items")
                                    .font(.custom("Audiowide-Regular", size: 17))
                                    .foregroundStyle(.peachOrange)
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(height: 2)
                                    .frame(maxWidth: .infinity)
                            }
                            
                            HStack {
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(height: 2)
                                    .frame(maxWidth: .infinity)
                                Text("Powerups")
                                    .font(.custom("Audiowide-Regular", size: 17))
                                    .foregroundStyle(.peachOrange)
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(height: 2)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding()
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

#Preview {
    var viewModel = MenuViewModel()
    
    StoreView()
        .environmentObject(viewModel)
}
