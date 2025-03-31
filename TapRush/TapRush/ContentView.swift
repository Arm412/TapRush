//
//  ContentView.swift
//  TapRush
//
//  Created by Adam Mitro on 12/13/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var menuVM = MenuViewModel()
    @StateObject private var navigationVM = NavigationViewModel()
    
    init(){
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    var body: some View {
        NavigationStack(path: $navigationVM.navigationPath) {
            DashboardView()
                .environmentObject(menuVM)
                .environmentObject(navigationVM)
                .navigationDestination(for: Screen.self) { screen in
                    switch screen {
                    case .dashboard:
                        DashboardView()
                            .environmentObject(menuVM)
                            .environmentObject(navigationVM)
                    case .miningMenu:
                        MiningMenuView(selectedMine: $menuVM.currentMine)
                            .environmentObject(menuVM)
                            .environmentObject(navigationVM)
                    case .awards:
                        AwardsView()
                    case .inventory:
                        InventoryView()
                            .environmentObject(menuVM)
                    case .map:
                        MapView()
                            .environmentObject(menuVM)
                    case .orders:
                        OrdersView()
                    case .pawnShop:
                        PawnShopView()
                            .environmentObject(menuVM)
                    case .store:
                        StoreView()
                    case .mining:
                        MineView(navPath: menuVM.navPathBinding).environmentObject(menuVM)
                            .environmentObject(navigationVM)
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
