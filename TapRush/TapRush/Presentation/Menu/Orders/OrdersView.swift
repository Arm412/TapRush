//
//  OrdersView.swift
//  TapRush
//
//  Created by Adam Mitro on 1/27/25.
//

import SwiftUI

struct OrdersView: View {
    var body: some View {
        VStack(alignment: HorizontalAlignment.center) {
            TopNavBarView()
            Spacer()
            Text("View to show gem orders")
                .font(.custom("Audiowide-Regular", size: 40))
                .foregroundStyle(Color.peachOrange)
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.outerSpace)
    }
}

#Preview {
    OrdersView()
}
