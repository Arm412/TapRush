//
//  PawnShopView.swift
//  TapRush
//
//  Created by Adam Mitro on 1/27/25.
//

import SwiftUI

struct PawnShopView: View {
    @EnvironmentObject var menuVM: MenuViewModel
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.center) {
            TopNavBarView(title: "Pawn Shop")
            VStack(alignment: .center) {
                ForEach($menuVM.inventory.gemList, id: \.self) { item in
                    HStack {
                        TradeItemView(gem: item)
                    }
                }
            }
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
