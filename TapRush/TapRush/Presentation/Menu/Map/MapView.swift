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

    var body: some View {
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
                Text("\(allMines[mineIndex].name.rawValue)")
                    .adaptiveFontSize(customFontName: "Audiowide-Regular")
                    .foregroundStyle(.peachOrange)
                    .multilineTextAlignment(.center)
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
