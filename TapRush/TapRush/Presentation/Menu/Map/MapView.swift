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
                        Image("worldMap4")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 4000, height: 2000)
                            .id("mapImage")
                        
//                        Image(systemName: "flag.fill")
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 40, height: 40)
//                            .id("mineFlag")
//                            .position(CGPoint(x: menuVM.mine.coordinates.0, y: menuVM.mine.coordinates.0))
//                            .onAppear {
//                                DispatchQueue.main.async {
//                                    proxy.scrollTo("mineFlag", anchor: .center)
//                                }
//                            }
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
        .background(.outerSpace)
    }
    
}

#Preview {
    var viewModel: MenuViewModel = .init()
    
    MapView()
        .environmentObject(viewModel)
}
