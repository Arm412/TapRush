//
//  PowerupModalView.swift
//  TapRush
//
//  Created by Adam Mitro on 6/1/25.
//

import SwiftUI

struct PowerupModalView: View {
    @EnvironmentObject private var menuVM: MenuViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack {
                    Text("Choose which powerups to activate:")
                        .font(.custom("Audiowide-Regular", size: 20))
                        .foregroundStyle(Color.black)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 15)
                    ForEach($menuVM.powerupList.indices, id: \.self) { index in
                        let powerup = $menuVM.powerupList[index]
                        HStack {
                            Spacer()
                            HStack {
                                Image(systemName: "questionmark")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.white)
                                    .frame(width: 45, height: 45)
                                    .padding()
                                    .border(.gray, width: 2)
                                Text(menuVM.powerupList[index].name)
                                    .font(.custom("Audiowide-Regular", size: 15))
                                    .foregroundStyle(Color.black)
                                    .frame(width: 70)
                                Text("x\(menuVM.powerupList[index].count)")
                                    .font(.custom("Audiowide-Regular", size: 15))
                                    .foregroundStyle(Color.black)
                                    .padding(.top, 20)
                                Button(action: {
                                    powerup.isActive.wrappedValue.toggle()
                                }) {
                                    Image(systemName: powerup.isActive.wrappedValue ? "checkmark.square" : "x.square")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(powerup.isActive.wrappedValue ? .green : .red)
                                        .frame(width: 45, height: 45)
                                        .padding()
                                }
                            }
                            Spacer()
                        }
                    }
                    
                }
                Spacer()
            }
        }
        .background(Color.black.opacity(0.2))
    }
}

#Preview {
    let viewModel = MenuViewModel()
    
    PowerupModalView().environmentObject(viewModel)
}
