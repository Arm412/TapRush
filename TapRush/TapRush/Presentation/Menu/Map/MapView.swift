//
//  MapView.swift
//  TapRush
//
//  Created by Adam Mitro on 1/27/25.
//

import SwiftUI

struct MapView: View {
    @EnvironmentObject var menuVM: MenuViewModel
    
    @Binding var allMines: [Mine]
    @Binding var activeMineIndex: Int // the active mine index
    
    @State var currentIndex: Int // current index on map screen
    
    let gemOrder: [GemType] = [.common, .uncommon, .rare, .legendary, .mythical]
    
    let columns: [GridItem] = [
        GridItem(.flexible(maximum: UIScreen.main.bounds.width/2)),
        GridItem(.flexible(maximum: UIScreen.main.bounds.width/2))
    ]

    var body: some View {
        GeometryReader { geo in
            VStack {
                TopNavBarView(foregroundColor: .peachOrange, title: Strings.map)
                
                HStack {
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.peachOrange)
                        .padding(.leading, 5)
                        .onTapGesture {
                            if currentIndex == 0 {
                                currentIndex = allMines.count - 1
                            } else {
                                currentIndex -= 1
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
                                        .underline(mine.isActive)
                                }
                            }
                            .onAppear {
                                proxy.scrollTo(allMines[activeMineIndex].name.rawValue, anchor: .center)
                            }
                            .onChange(of: currentIndex) { _, newValue in
                                withAnimation {
                                    proxy.scrollTo(allMines[currentIndex].name.rawValue, anchor: .center)
                                }
                            }
                        }
                    }
                    .frame(height: 40)
                    .allowsHitTesting(false)

                    
                    Spacer()
                    Image(systemName: "arrow.forward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.peachOrange)
                        .padding(.trailing, 5)
                        .onTapGesture {
                            if currentIndex < allMines.count - 1 {
                                currentIndex += 1
                            } else {
                                currentIndex = 0
                            }
                        }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollViewReader { proxy in
                        LazyHStack {
                            ForEach(allMines) { mine in
                                Text("\(mine.name.rawValue)")
                                    .adaptiveFontSize(customFontName: "Audiowide-Regular")
                                    .foregroundStyle(mine.secondaryColor)
                                    .frame(width: geo.size.width)
                                    .id(mine.name.rawValue)
                            }
                        }
                        .onAppear {
                            proxy.scrollTo(allMines[activeMineIndex].name.rawValue, anchor: .center)
                        }
                        .onChange(of: currentIndex) { _, newValue in
                            withAnimation {
                                proxy.scrollTo(allMines[currentIndex].name.rawValue, anchor: .center)
                            }
                        }
                    }
                }
                .allowsHitTesting(false)
                .frame(height: 200)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollViewReader { proxy in
                        LazyHStack {
                            ForEach(allMines) { mine in
                                gemProbabilitiesView(mine: mine, geo: geo)
                                    .frame(maxHeight: .none)
                            }
                        }
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                proxy.scrollTo(allMines[activeMineIndex].name.rawValue, anchor: .center)
                            }
                        }
                        .onChange(of: currentIndex) { _, newValue in
                            withAnimation {
                                proxy.scrollTo(allMines[currentIndex].name.rawValue, anchor: .center)
                            }
                        }
                        .frame(minHeight: 0, maxHeight: geo.size.height * 0.4)
                    }
                }
                .allowsHitTesting(false)
                .frame(minHeight: 0, maxHeight: geo.size.height * 0.4)
                .background(Color.outerSpace)
                Spacer()
                Button(action: { setCurrentMine() }) {
                    Text(Strings.setAsActiveMine)
                        .font(.custom("Audiowide-Regular", size: 22))
                        .padding()
                        .border(.peachOrange, width: 3)
                }
                .foregroundStyle(.peachOrange)
                .padding(.bottom, 10)
            }
            .navigationBarBackButtonHidden(true)
            .background(Color.outerSpace)
        }
    }
    
    private func gemProbabilitiesView(mine: Mine, geo: GeometryProxy) -> some View {
        let mineGemProbabilityList = mine.gemProbabilities.gemsProbabilityList
        
        return VStack(alignment: .leading) {
            Text("\(mine.description)")
                .foregroundStyle(.peachOrange)
                .font(.custom("Audiowide-Regular", size: 20))
                .padding(.top, 5)
            Text(Strings.gemProbabilities)
                .font(.custom("Audiowide-Regular", size: 25))
                .foregroundStyle(.peachOrange)
            LazyVGrid(columns: columns, spacing: 30) {
                ForEach(Array(gemOrder), id: \.self) { gem in
                    if (mineGemProbabilityList[gem] ?? 0 > 0) {
                        HStack {
                            Image(GemHelpers.getGemIcon(for: gem))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            
                            Text(": \((mineGemProbabilityList[gem] ?? 0) * 100, specifier: "%.1f")%")
                                .foregroundStyle(.white)
                        }
                    }
                }
                if (mine.gemProbabilities.noGemProbability > 0) {
                    HStack {
                        Image("nothing")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.red)
                        Text(": \(mine.gemProbabilities.noGemProbability * 100, specifier: "%.1f")%")
                            .foregroundStyle(.white)
                    }
                }
            }
            Spacer()
        }
        .padding()
        .frame(width: geo.size.width, height: geo.size.height * 0.4)
        .id(mine.name.rawValue)
    }
    
    private func setCurrentMine() {
        allMines[activeMineIndex].isActive = false
        allMines[currentIndex].isActive = true
        
        activeMineIndex = currentIndex

        menuVM.saveCurrentMine()
    }
}

#Preview {
    @Previewable @State var indx = 0
    @Previewable @State var mineList: [Mine] = MineHelpers.allMines
    
    var viewModel: MenuViewModel = .init()
    
    MapView(allMines: $mineList, activeMineIndex: $indx, currentIndex: indx)
        .environmentObject(viewModel)
}
