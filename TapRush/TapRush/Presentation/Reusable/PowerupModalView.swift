//
//  PowerupModalView.swift
//  TapRush
//
//  Created by Adam Mitro on 6/1/25.
//

import SwiftUI

struct PowerupModalView: View {
    @EnvironmentObject private var menuVM: MenuViewModel
    @EnvironmentObject private var navigationVM: NavigationViewModel
    
    let closeAction: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {
                        closeAction()
                    }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color.peachOrange)
                    }
                    .padding()
                    Spacer()
                }
                Spacer()
                VStack {
                    Text("Choose which powerups to activate:")
                        .font(.custom("Audiowide-Regular", size: 20))
                        .foregroundStyle(Color.peachOrange)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 15)
                    ForEach($menuVM.powerupList.indices, id: \.self) { index in
                        HStack {
                            PowereupRowView(powerup: menuVM.powerupList[index], toggleActive: {
                                menuVM.powerupList[index].isActive.toggle()
                            })
                            .padding(.leading, 10)
                        }
                    }
                    
                }
                Spacer()
                Button(action: {
                    navigationVM.navigateTo(screen: .mining)
                }) {
                    Text("Start")
                        .font(.custom("Audiowide-Regular", size: 65))
                        .foregroundStyle(Color.peachOrange)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .background(Color.black.opacity(0.9))
    }
}

struct PowereupRowView: View {
    var powerup: Powerup
    var toggleActive: () -> Void
    
    private func checkboxImage(powerup: Powerup) -> some View {
        if powerup.count == 0 {
            return Image(systemName: "x.square")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.gray)
                .frame(width: 45, height: 45)
                .padding()
        } else if powerup.isActive {
            return Image(systemName: "checkmark.square")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.green)
                .frame(width: 45, height: 45)
                .padding()
        } else {
            return Image(systemName: "x.square")
                .resizable()
                .scaledToFit()
                .foregroundStyle(powerup.count == 0 ? .gray : .red)
                .frame(width: 45, height: 45)
                .padding()
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: "questionmark")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 45, height: 45)
                .padding()
                .border(.gray, width: 2)
            Text(powerup.name)
                .font(.custom("Audiowide-Regular", size: 15))
                .foregroundStyle(Color.peachOrange)
                .frame(width: 70)
            Text("x\(powerup.count)")
                .font(.custom("Audiowide-Regular", size: 15))
                .foregroundStyle(Color.peachOrange)
                .padding(.top, 20)
                .frame(width: 70)
            Button(action: {
                toggleActive()
            }) {
                checkboxImage(powerup: powerup)
            }
        }
    }
}

#Preview {
    let viewModel = MenuViewModel()
    
    PowerupModalView(closeAction: {}).environmentObject(viewModel)
}
