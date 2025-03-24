//
//  MapView.swift
//  TapRush
//
//  Created by Adam Mitro on 1/27/25.
//

import SwiftUI

struct MapView: View {
    @EnvironmentObject var menuVM: MenuViewModel
    var allMines = MineHelpers.allMines
    @State var mineIndex = 0
    
    let gemOrder: [GemType] = [.common, .uncommon, .rare, .legendary, .mythical]
    
    let columns: [GridItem] = [
        GridItem(.flexible(maximum: UIScreen.main.bounds.width/2)),
        GridItem(.flexible(maximum: UIScreen.main.bounds.width/2))
    ]

    var body: some View {
        GeometryReader { geo in
            VStack {
                TopNavBarView(foregroundColor: .peachOrange, title: "Maps")
                
                HStack {
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.peachOrange)
                        .padding(.leading, 5)
                        .onTapGesture {
                            if mineIndex == 0 {
                                mineIndex = allMines.count - 1
                            } else {
                                mineIndex -= 1
                            }
                        }
                    Spacer()
                    ScrollView(.horizontal, showsIndicators: false) {
                        ScrollViewReader { proxy in
                            LazyHStack {
                                ForEach(allMines) { mine in
                                    Text("\(mine.name.rawValue)")
                                        .font(.custom("Audiowide-Regular", size: 22))
                                        .foregroundStyle(.peachOrange)
                                        .multilineTextAlignment(.center)
                                        .frame(minWidth: geo.size.width - 90)
                                        .id(mine.name.rawValue)
                                }
                            }
                            .onAppear {
                                proxy.scrollTo(allMines[mineIndex].name.rawValue, anchor: .center)
                            }
                            .onChange(of: mineIndex) { _, newValue in
                                withAnimation {
                                    proxy.scrollTo(allMines[mineIndex].name.rawValue, anchor: .center)
                                }
                            }
                        }
                    }
                    .frame(height: 40)

                    
                    Spacer()
                    Image(systemName: "arrow.forward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.peachOrange)
                        .padding(.trailing, 5)
                        .onTapGesture {
                            if mineIndex < allMines.count - 1 {
                                mineIndex += 1
                            } else {
                                mineIndex = 0
                            }
                        }
                }
                
                VStack {
                    Text("\(allMines[mineIndex].name.rawValue)")
                        .adaptiveFontSize(customFontName: "Audiowide-Regular")
                        .foregroundStyle(allMines[mineIndex].secondaryColor)
                }
                .frame(maxWidth: .infinity, maxHeight: 200)
                .border(allMines[mineIndex].primaryColor, width: 5)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollViewReader { proxy in
                        LazyHStack {
                            ForEach(allMines) { mine in
                                gemProbabilitiesView(mine: mine, geo: geo)
                            }
                        }
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                proxy.scrollTo(allMines[mineIndex].name.rawValue, anchor: .center)
                            }
                        }
                        .onChange(of: mineIndex) { _, newValue in
                            withAnimation {
                                proxy.scrollTo(allMines[mineIndex].name.rawValue, anchor: .center)
                            }
                        }
                    }
                }
                .frame(width: geo.size.width)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
            .background(Color.outerSpace)
        }
    }
    
    private func gemProbabilitiesView(mine: Mine, geo: GeometryProxy) -> some View {
        let mineGemProbabilityList = mine.gemProbabilities.gemsProbabilityList
        return VStack {
            HStack {
                Text("\(mine.description)")
                    .adaptiveFontSize(customFontName: "Audiowide-Regular")
                    .foregroundStyle(allMines[mineIndex].secondaryColor)
            }
            Text("Gem Probabilities:")
                .adaptiveFontSize(customFontName: "Audiowide-Regular")
                .foregroundStyle(allMines[mineIndex].secondaryColor)
            LazyVGrid(columns: columns, spacing: 30) {
                ForEach(Array(gemOrder), id: \.self) { gem in
                    if (mineGemProbabilityList[gem] ?? 0 > 0) {
                        HStack {
                            Image(GemHelpers.getGemIcon(for: gem))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                            
                            Text(": \(mineGemProbabilityList[gem] ?? 0)")
                                .foregroundStyle(.white)
                        }
                    }
                }
                if (mine.gemProbabilities.noGemProbability > 0) {
                    Text("Nothing: \(mine.gemProbabilities.noGemProbability)")
                        .foregroundStyle(.white)
                }
            }
            
            Spacer()
        }
        .padding()
        .frame(width: geo.size.width)
        .border(allMines[mineIndex].primaryColor, width: 5)
        .id(mine.name.rawValue)
    }
}


#Preview {
    var viewModel: MenuViewModel = .init()
    
    MapView()
        .environmentObject(viewModel)
}
