//
//  TopNavBarView.swift
//  TapRush
//
//  Created by Adam Mitro on 1/28/25.
//

import SwiftUI

struct TopNavBarView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var menuVM: MenuViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.backward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Color.peachOrange)
            }
            Spacer()
            VStack {
                HStack {
                    HStack {
                        Image("purpEmerald1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text("\(menuVM.gems.common)")
                            .foregroundStyle(Color.peachOrange)
                            .font(.system(size: 20))
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                    HStack {
                        Text("UC")
                            .frame(width: 40, height: 40)
                            .background(.green)
                        Text("\(menuVM.gems.uncommon)")
                            .foregroundStyle(Color.peachOrange)
                            .font(.system(size: 20))
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                    HStack {
                        Text("Rare")
                            .frame(width: 40, height: 40)
                            .background(.blue)
                        Text("\(menuVM.gems.rare)")
                            .foregroundStyle(Color.peachOrange)
                            .font(.system(size: 20))
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
                HStack {
                    HStack {
                        Text("L")
                            .frame(width: 40, height: 40)
                            .background(.yellow)
                        Text("\(menuVM.gems.legendary)")
                            .foregroundStyle(Color.peachOrange)
                            .font(.system(size: 20))
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                    HStack {
                        Text("Myth")
                            .frame(width: 40, height: 40)
                            .background(.purple)
                        Text("\(menuVM.gems.mythical)")
                            .foregroundStyle(Color.peachOrange)
                            .font(.system(size: 20))
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                    HStack {
                        Text("Gold")
                            .frame(width: 40, height: 40)
                        Text("\(menuVM.gold.count)")
                            .foregroundStyle(Color.peachOrange)
                            .font(.system(size: 20))
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
            }
            .foregroundStyle(Color.black)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .overlay(
            Rectangle()
                .frame(height: 2)
                .foregroundColor(Color.peachOrange)
                .padding(.top, 48),
            alignment: .bottom
        )
    }
}

#Preview {
    var menuVM = MenuViewModel()
    
    TopNavBarView()
        .environmentObject(menuVM)
}
