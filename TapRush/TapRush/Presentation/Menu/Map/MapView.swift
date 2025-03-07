//
//  MapView.swift
//  TapRush
//
//  Created by Adam Mitro on 1/27/25.
//

import SwiftUI

struct MapView: View {
    @EnvironmentObject var menuVM: MenuViewModel
    @State private var scrollOffset: CGPoint = CGPoint(x: 1000, y: 500)

    var body: some View {
        VStack {
            TopNavBarView(foregroundColor: .peachOrange, title: "Maps")
            
            HStack {
                Image(systemName: "arrow.backward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.peachOrange)
                Text("\(menuVM.currentMine.rawValue)")
                    .adaptiveFontSize(customFontName: "Audiowide-Regular")
                    .foregroundStyle(.peachOrange)
                    .multilineTextAlignment(.center)
                Image(systemName: "arrow.forward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.peachOrange)
            }

            GeometryReader { geo in
                ScrollView([.horizontal, .vertical], showsIndicators: false) {
                    ScrollViewReader { proxy in
                        ZStack {
                            Image("worldMap4")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 4000, height: 2000)

                            ForEach(menuVM.mineList) { mine in
                                Image(systemName: "flag.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(.red)
                                    .position(x: CGFloat(mine.coordinates.0),
                                              y: CGFloat(mine.coordinates.1))
                                    .id(mine.name.rawValue)
                            }
                        }
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                if menuVM.mineList.contains(where: { $0.name == menuVM.currentMine }) {
                                    proxy.scrollTo(menuVM.currentMine.rawValue, anchor: .center)
                                }
                            }
                        }
                    }
                }
                .frame(width: geo.size.width, height: 275)
                .edgesIgnoringSafeArea(.all)
                .border(.peachOrange, width: 5)
            }
            .edgesIgnoringSafeArea(.all)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
        .background(Color.outerSpace)
    }
}


#Preview {
    var viewModel: MenuViewModel = .init()
    
    MapView()
        .environmentObject(viewModel)
}
