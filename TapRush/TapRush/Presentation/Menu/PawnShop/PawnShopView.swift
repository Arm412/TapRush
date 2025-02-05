//
//  PawnShopView.swift
//  TapRush
//
//  Created by Adam Mitro on 1/27/25.
//

import SwiftUI

struct PawnShopView: View {
    var body: some View {
        VStack(alignment: HorizontalAlignment.center) {
            TopNavBarView(title: "Pawn Shop")
            Spacer()
            Text("View to display the gem pawn shop.")
                .font(.custom("Audiowide-Regular", size: 40))
                .foregroundStyle(Color.peachOrange)
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.outerSpace)
    }
}

#Preview {
    PawnShopView()
}
