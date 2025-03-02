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
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack(alignment: HorizontalAlignment.center) {
                    TopNavBarView(title: Strings.pawnShop)
                    
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
                        Text(Strings.convertedGold)
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
                            Text("You are about to sell:")
                            if(sellGemCount.common > 0) {
                                HStack {
                                    Image("purpEmerald1")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    Text("x\(sellGemCount.common)")
                                }
                            }
                            if(sellGemCount.uncommon > 0) {
                                HStack {
                                    Image("purpEmerald2")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    Text("x\(sellGemCount.uncommon)")
                                }
                            }
                            if(sellGemCount.rare > 0) {
                                HStack {
                                    Image("sapphire")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    Text("x\(sellGemCount.rare)")
                                }
                            }
                            if(sellGemCount.legendary > 0) {
                                HStack {
                                    Image("emerald")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    Text("x\(sellGemCount.legendary)")
                                }
                            }
                            if(sellGemCount.mythical > 0) {
                                HStack {
                                    Image("diamond")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    Text("x\(sellGemCount.mythical)")
                                }
                            }
                            
                            Text("for")
                            
                            HStack {
                                Image("gold")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                Text("x\(totalGoldConverted)")
                            }
                            
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
                        .onAppear {
                            print("sellGemCount")
                            print(sellGemCount)
                        }
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

struct SoldGemCounts {
    var common: Int = 0
    var uncommon: Int = 0
    var rare: Int = 0
    var legendary: Int = 0
    var mythical: Int = 0
}

#Preview {
    var viewModel = MenuViewModel()
    
    PawnShopView()
        .environmentObject(viewModel)
}
