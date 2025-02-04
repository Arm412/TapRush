//
//  DashboardView.swift
//  TapRush
//
//  Created by Adam Mitro on 12/13/24.
//

import SwiftUI

struct DashboardView: View {
    @State var selectedMine: String = "Pebblebrook Quarry"
    @StateObject private var menuVM = MenuViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("TapRush!")
                    .font(.custom("Audiowide-Regular", size: 70))
                    .foregroundStyle(Color.peachOrange)
                    .frame(maxWidth: .infinity)

                GeometryReader { geometry in
                    VStack {
                        NavigationLink(destination: MiningMenuView()) {
                            Text("Menu")
                                .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
                                .frame(width: geometry.size.width * 0.9)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.peachOrange, lineWidth: 5)
                                )
                                .font(.custom("Audiowide-Regular", size: 40))
                                .foregroundStyle(Color.peachOrange)
                        }
                        
                        Spacer()

                        NavigationLink(destination: MineView().environmentObject(menuVM)) {
                            HStack {
                                Text("To the Mines!")
                                    .font(.custom("Audiowide-Regular", size: 25))
                                    .foregroundStyle(.peachOrange)
                                Image("pickaxeAnimation5")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(.peachOrange)
                            }
                            .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
                            .frame(width: geometry.size.width * 0.9)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.peachOrange, lineWidth: 5)
                            )
                        }
                        
                        Spacer()

                        NavigationLink(destination: MiningMenuView()) {
                            Text("Quick Play")
                                .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
                                .frame(width: geometry.size.width * 0.9)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.peachOrange, lineWidth: 5)
                                )
                                .font(.custom("Audiowide-Regular", size: 40))
                                .foregroundStyle(Color.peachOrange)
                                .frame(width: geometry.size.width * 0.9)
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
            .background(Color.outerSpace)


        }
    }
}

#Preview {
    DashboardView()
}
