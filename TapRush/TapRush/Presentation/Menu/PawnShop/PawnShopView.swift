//
//  PawnShopView.swift
//  TapRush
//
//  Created by Adam Mitro on 1/27/25.
//

import SwiftUI

struct PawnShopView: View {
    @EnvironmentObject var menuVM: MenuViewModel
    @State var totalGoldConverted: Int = 0
    @State var sellGemsPressed: Bool = false
    @State var totalGemsSold: Int = 0
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack(alignment: HorizontalAlignment.center) {
                    TopNavBarView(title: Strings.pawnShop)
                    
                    VStack(alignment: .center) {
                        ForEach($menuVM.inventory.gemList, id: \.self) { item in
                            HStack {
                                TradeItemView(gem: item, totalGold: $totalGoldConverted, totalGems: $totalGemsSold)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    HStack {
                        Spacer()
                        Text(Strings.totalGold)
                            .foregroundStyle(.peachOrange)
                            .adaptiveFontSize(customFontName: "Audiowide-Regular")
                        Text("\(totalGoldConverted)")
                            .foregroundStyle(.peachOrange)
                            .adaptiveFontSize(customFontName: "Audiowide-Regular")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.trailing, 30)
                    if (totalGoldConverted > 0) {
                        HStack {
                            Spacer()
                            Text(Strings.sell)
                                .foregroundStyle(.peachOrange)
                                .adaptiveFontSize(customFontName: "Audiowide-Regular")
                                .padding()
                                .border(.peachOrange, width: 4)
                                .onTapGesture {
                                    sellGemsPressed = true
                                }
                            Spacer()
                        }
                        .padding(.top, 25)
                    }
                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.outerSpace)
                
                if (sellGemsPressed) {
                    ZStack {
                        VStack {
                            Text("You are about to sell \(totalGemsSold) \(totalGemsSold > 1 ? "gems" : "gem") for \(totalGoldConverted) gold.")
                            HStack {
                                Button("Close", action: {
                                    sellGemsPressed = false
                                })
                                .font(.custom("Audiowide-Regular", size: 30))
                                .foregroundStyle(.white)
                                .padding()
                                
                                Button("Confirm", action: {
                                    sellGemsPressed = false
                                })
                                .font(.custom("Audiowide-Regular", size: 30))
                                .foregroundStyle(.green)
                                .padding()
                            }
                        }
                        .padding(EdgeInsets(top: 20, leading: 10, bottom: 5, trailing: 10))
                        .background(.outerSpace)
                        .foregroundStyle(Color.white)
                        .border(.red, width: 5)
                        .padding()
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                    .background(Color.black.opacity(0.2))
                    .onTapGesture {
                        sellGemsPressed = false
                    }
                }
            }
        }
    }
}

#Preview {
    var viewModel = MenuViewModel()
    
    PawnShopView()
        .environmentObject(viewModel)
}
