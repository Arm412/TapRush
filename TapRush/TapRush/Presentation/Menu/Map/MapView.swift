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
    @State var showGemProbabilityOverlay: Bool = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
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
                                    VStack {
                                        HStack(alignment: .top) {
                                            VStack(alignment: .leading) {
                                                Text("\(mine.description)")
                                                    .foregroundStyle(.peachOrange)
                                                    .font(.custom("Audiowide-Regular", size: 20))
                                                    .padding(.top, 5)
                                            }
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    .padding()
                                    .frame(width: geo.size.width, height: 200)
                                    .id(mine.name.rawValue)
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
                            .frame(minHeight: 0, maxHeight: 200)
                        }
                    }
                    .allowsHitTesting(false)
                    .frame(minHeight: 0, maxHeight: 200)
                    .background(Color.outerSpace)
                    
                    Button(action: { showGemProbabilityOverlay.toggle() }) {
                        Text(Strings.showGemProbabilities)
                            .font(.custom("Audiowide-Regular", size: 15))
                            .foregroundStyle(.white)
                            .padding(.top, 10)
                        
                    }
                    .foregroundStyle(.peachOrange)
                    .padding(.bottom, 10)
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
                
                if showGemProbabilityOverlay {
                    ZStack(alignment: .topTrailing) {
                        Color.black.opacity(0.8)
                            .edgesIgnoringSafeArea(.all)
                        
                        VStack(alignment: .leading) {
                            Spacer()
                            GemProbabilityOverlayView(geoHeight: geo.size.height, geoWidth: geo.size.width, mineGemProbabilityList: allMines[currentIndex].gemProbabilities.gemsProbabilityList, mineNoGemProbability: allMines[currentIndex].gemProbabilities.noGemProbability)
                            Spacer()
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.white)
                            .padding()
                    }
                    .onTapGesture {
                        showGemProbabilityOverlay.toggle()
                    }
                }
            }
        }
    }
    
    private func setCurrentMine() {
        allMines[activeMineIndex].isActive = false
        allMines[currentIndex].isActive = true
        
        activeMineIndex = currentIndex
        menuVM.activeMineName = allMines[activeMineIndex].name.rawValue
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
