//
//  DashboardView.swift
//  TapRush
//
//  Created by Adam Mitro on 12/13/24.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var menuVM: MenuViewModel
    @EnvironmentObject private var navigationVM: NavigationViewModel
    
    var body: some View {
        VStack {
            Text(Strings.dashboardTitle)
                .font(.custom("Audiowide-Regular", size: 65))
                .foregroundStyle(Color.peachOrange)
                .frame(maxWidth: .infinity)
            
            GeometryReader { geometry in
                VStack {
                    Text(Strings.menu)
                        .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.2)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.peachOrange, lineWidth: 5)
                        )
                        .adaptiveFontSize(customFontName: "Audiowide-Regular")
                        .foregroundStyle(Color.peachOrange)
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                        .contentShape(RoundedRectangle(cornerRadius: 15))
                        .onTapGesture {
                            navigationVM.navigateTo(screen: Screen.miningMenu)
                        }
                    HStack {
                        Text(Strings.goMining)
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
                    .contentShape(RoundedRectangle(cornerRadius: 15))
                    .onTapGesture {
                        navigationVM.navigateTo(screen: Screen.mining)
                    }
                    Text(Strings.quickPLay)
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
                        .contentShape(RoundedRectangle(cornerRadius: 15))
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
                Text(Strings.currentDestination)
                    .foregroundStyle(.peachOrange)
                    .font(.custom("Audiowide-Regular", size: 25))
                Text("\(menuVM.currentMine.name.rawValue)")
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
    let viewModel = MenuViewModel()
    DashboardView()
        .environmentObject(viewModel)
}
