//
//  MineView.swift
//  TapRush
//
//  Created by Adam Mitro on 1/24/25.
//

import SwiftUI

struct MineView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var menuVM: MenuViewModel
    
    var body: some View {
        VStack {
            TopNavBarView()
            
            Spacer()
            
            GeometryReader { geo in
                ZStack {
                    ForEach(menuVM.rocks.indices, id: \.self) { index in
                        let rock = menuVM.rocks[index]
                        
                        if !rock.isDepleted {
                            rockImageView(for: rock, at: index)
                        } else {
                            dustAndGemImageView(for: rock, at: index)
                        }
                    }
                }
                .onAppear {
                    menuVM.initRocks(geo: geo)
                }
                .onDisappear {
                    menuVM.save()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.outerSpace)
            .navigationBarBackButtonHidden(true)
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.outerSpace)
    }
    
    private func rockImageView(for rock: Rock, at index: Int) -> some View {
        Image(rock.states[rock.stateIndex])
            .position(rock.position)
            .onTapGesture {
                handleRockTap(for: rock, at: index)
            }
    }
    
    private func dustAndGemImageView(for rock: Rock, at index: Int) -> some View {
        if !rock.dustSettled {
            return AnyView(
                Image(rock.dust.dustCloudSprites[rock.dust.spriteIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .position(rock.position)
                    .onAppear {
                        menuVM.startStateUpdateTimer(index: index)
                    }
            )
        } else {
            return AnyView(
                Image(rock.gemSprites[0])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .position(rock.position)
                    .onTapGesture {
                        handleGemTap(for: rock, at: index)
                    }
            )
        }
    }
    
    private func handleRockTap(for rock: Rock, at index: Int) {
        print("Pressed \(rock.stateIndex)")
        menuVM.rocks[index].stateIndex += 1
        if menuVM.rocks[index].stateIndex == rock.states.count {
            menuVM.rocks[index].isDepleted = true
        }
    }
    
    private func handleGemTap(for rock: Rock, at index: Int) {
        menuVM.rocks[index] = menuVM.createRock()
        menuVM.updateGemCount(gemType: rock.gemType)
    }
}

#Preview {
    var menuVM = MenuViewModel()
    
    MineView()
        .environmentObject(menuVM)
}
