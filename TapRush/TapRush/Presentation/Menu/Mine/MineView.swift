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
    @EnvironmentObject var navigationVM: NavigationViewModel
    
    @State var showMenu: Bool = false
    @State var menuIsShown: Bool = false
    @State var showAlert: Bool = false
    @State var selectedScreen: Screen = .mining
    @Binding var navPath: NavigationPath
    
    var safeAreaTop: CGFloat {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .first(where: { $0.isKeyWindow })?
            .safeAreaInsets.top ?? 0
    }

    var safeAreaBottom: CGFloat {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .first(where: { $0.isKeyWindow })?
            .safeAreaInsets.bottom ?? 0
    }
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        ZStack(alignment: Alignment.leading) {
            VStack {
                TopNavBarView(foregroundColor: .peachOrange, menuHandler: { showMenu.toggle() }, title: Strings.mine, isMining: true)
                    .padding(.top, safeAreaTop)
                
                Spacer()
                
                GeometryReader { mineGeo in
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
                        menuVM.initRocks(geo: mineGeo)
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
            
            // Menu Overlay view
            if showMenu {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.peachOrange)
                            .padding()
                            .onTapGesture {
                                withAnimation {
                                    showMenu.toggle()
                                }
                            }
                        
                    }
                    ForEach(menuVM.miningMenuNavButtons) { item in
                        HStack {
                            Image(systemName: item.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.peachOrange)
                                .padding()
                                .onTapGesture {
                                    withAnimation {
                                        showMenu.toggle()
                                    }
                                }
                            
                            Text(item.name)
                                .font(.custom("Audiowide-Regular", size: 30))
                                .foregroundStyle(.peachOrange)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 10) // Add horizontal padding
                        .onTapGesture {
                            showAlert = true
                            selectedScreen = item.destination
                        }
                    }
                    Spacer()
                }
                .frame(width: showMenu ? screenWidth * 0.8 : 0)
                .background(.outerSpace)
                .border(.peachOrange, width: 2)
                .padding(.top, safeAreaTop + 1)
                .padding(.bottom, safeAreaBottom)
                .transition(.move(edge: .leading))
            }
            
            if(showAlert) {
                ZStack {
                    VStack {
                        Text(Strings.warning1)
                        Text(Strings.warning2)
                        
                        HStack {
                            Button(Strings.leave, action: {
                                print("Leave")
                                showAlert = false
                                navigationVM.resetNavigation()
                                navigationVM.navigateTo(screen: .dashboard)
                                navigationVM.navigateTo(screen: .miningMenu)
                                navigationVM.navigateTo(screen: selectedScreen)
                            })
                            .font(.custom("Audiowide-Regular", size: 30))
                            .foregroundStyle(Color.red)
                            .padding()
                            
                            Button(Strings.stay, action: {
                                print("Stay")
                                showAlert = false
                            })
                            .font(.custom("Audiowide-Regular", size: 30))
                            .padding()
                        }
                    }
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 5, trailing: 10))
                    .background(.outerSpace)
                    .foregroundStyle(Color.white)
                    .border(.red, width: 5)
                    .padding()
                }
                .frame(width: screenWidth, height: screenHeight)
                .background(Color.black.opacity(0.2))
                .onTapGesture {
                    showAlert = false
                }
            }
        }
        .ignoresSafeArea(edges: .top)
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
                Image(rock.gem!.sprites[0])
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
        if let gem = rock.gem {
            menuVM.rocks[index] = menuVM.createRock()
            menuVM.updateGemCount(gem: gem, amount: 1)
        } else {
            menuVM.rocks[index] = menuVM.createRock()
        }
    }
}

#Preview {
    @Previewable @State var navPath = NavigationPath()
    var menuVM = MenuViewModel()
    
    MineView(navPath: $navPath)
        .environmentObject(menuVM)
}
