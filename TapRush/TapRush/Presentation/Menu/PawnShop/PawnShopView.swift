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
    @State var sellGemCount: SoldGemCounts = SoldGemCounts()
    
    var gemCounts: [Gem] {
        return [
            sellGemCount.common,
            sellGemCount.uncommon,
            sellGemCount.rare,
            sellGemCount.legendary,
            sellGemCount.mythical
        ]
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack(alignment: HorizontalAlignment.center) {
                    TopNavBarView(foregroundColor: .peachOrange, title: Strings.pawnShop)
                    
                    HStack {
                        Text(Strings.currentGold + "\(menuVM.gold.count)")
                            .foregroundStyle(.peachOrange)
                            .font(.custom("Audiowide-Regular", size: 25))
                            .frame(maxWidth: .infinity)
                    }
                    
                    VStack(alignment: .center) {
                        ForEach($menuVM.inventory.gemList) { item in
                            HStack {
                                TradeItemView(gem: item, totalGold: $totalGoldConverted, gemCount: $sellGemCount)
                                    .environmentObject(menuVM)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    HStack {
                        Spacer()
                        Text(Strings.goldPayout)
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
                            Text(Strings.youAreAboutToSell)
                            ForEach(gemCounts, id: \.self) { gem in
                                if gem.count > 0 {
                                    HStack {
                                        Image(gem.icon)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                        Text("x\(gem.count)")
                                    }
                                }
                            }
                            
                            Text(Strings.stringFor)
                            
                            HStack {
                                Image("gold")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                Text("x\(totalGoldConverted)")
                            }
                            
                            HStack {
                                Button(Strings.close, action: {
                                    sellGemsPressed = false
                                })
                                .font(.custom("Audiowide-Regular", size: 30))
                                .foregroundStyle(.white)
                                .padding()
                                
                                Button(Strings.confirm, action: {
                                    sellGemsPressed = false
                                    menuVM.sellGems(soldGems: sellGemCount, aqcuiredGold: totalGoldConverted)
                                    totalGoldConverted = 0
                                })
                                .font(.custom("Audiowide-Regular", size: 30))
                                .foregroundStyle(.green)
                                .padding()
                            }
                        }
                        .padding(EdgeInsets(top: 20, leading: 10, bottom: 5, trailing: 10))
                        .background(.outerSpace)
                        .foregroundStyle(Color.white)
                        .border(.white, width: 5)
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
