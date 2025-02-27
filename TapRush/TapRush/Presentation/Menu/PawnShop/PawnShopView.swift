//
//  PawnShopView.swift
//  TapRush
//
//  Created by Adam Mitro on 1/27/25.
//

import SwiftUI

struct PawnShopView: View {
    @EnvironmentObject var menuVM: MenuViewModel
    @State var totalGoldEarned: Int = 0
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.center) {
            TopNavBarView(title: "Pawn Shop")
            
            VStack(alignment: .center) {
                ForEach($menuVM.inventory.gemList, id: \.self) { item in
                    HStack {
                        TradeItemView(gem: item, totalGold: $totalGoldEarned)
                    }
                }
            }
            HStack {
                Spacer()
                Text("Total Gold: ")
                    .foregroundStyle(.peachOrange)
                    .adaptiveFontSize(customFontName: "Audiowide-Regular")
                Text("\(totalGoldEarned)")
                    .foregroundStyle(.peachOrange)
                    .adaptiveFontSize(customFontName: "Audiowide-Regular")
            }
            .frame(maxWidth: .infinity)
            .padding(.trailing, 30)
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.outerSpace)
    }
}

#Preview {
    var viewModel = MenuViewModel()
    
    PawnShopView()
        .environmentObject(viewModel)
}
