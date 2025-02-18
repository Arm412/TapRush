//
//  DashboardView.swift
//  TapRush
//
//  Created by Adam Mitro on 12/13/24.
//

import SwiftUI

struct DashboardView: View {
    @State var selectedMine: String = "Pebblebrook Quarry"
    @EnvironmentObject private var menuVM: MenuViewModel
    @EnvironmentObject private var navigationVM: NavigationViewModel
    
    var body: some View {
        VStack {
            Text("TapRush!")
                .font(.custom("Audiowide-Regular", size: 65))
                .foregroundStyle(Color.peachOrange)
                .frame(maxWidth: .infinity)
            
            GeometryReader { geometry in
                VStack {
                    Text("Menu")
                        .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.2)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.peachOrange, lineWidth: 5)
                        )
                        .adaptiveFontSize(customFontName: "Audiowide-Regular")
                        .foregroundStyle(Color.peachOrange)
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                        .onTapGesture {
                            navigationVM.navigateTo(screen: Screen.miningMenu)
                        }
                    HStack {
                        Text("Go Mining!")
                            .foregroundStyle(.peachOrange)
                            .adaptiveFontSize(customFontName: "Audiowide-Regular")
                        Image("pickaxeAnimation5")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.peachOrange)
                    }
                    .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.2)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.peachOrange, lineWidth: 5)
                    )
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                    .onTapGesture {
                        navigationVM.navigateTo(screen: Screen.mining)
                    }
                    Text("Quick Play")
                        .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.2)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.peachOrange, lineWidth: 5)
                        )
                        .adaptiveFontSize(customFontName: "Audiowide-Regular")
                        .foregroundStyle(Color.peachOrange)
                        .frame(width: geometry.size.width * 0.9)
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                        .onTapGesture {
                            navigationVM.navigateTo(screen: Screen.miningMenu)
                        }
                    Spacer()
                }
                .frame(maxHeight: geometry.size.height * 0.70)
                .padding(EdgeInsets(top: geometry.size.height * 0.15, leading: geometry.size.width * 0.05, bottom: 20, trailing: geometry.size.width * 0.05))
            }
            
            Spacer()
            
            VStack {
                Text("Current Destination:")
                    .foregroundStyle(.peachOrange)
                    .font(.custom("Audiowide-Regular", size: 25))
                Text(selectedMine)
                    .foregroundStyle(.peachOrange)
                    .font(.custom("Audiowide-Regular", size: 25))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(.outerSpace)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DashboardView()
}
