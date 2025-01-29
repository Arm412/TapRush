//
//  InventoryView.swift
//  TapRush
//
//  Created by Adam Mitro on 1/28/25.
//

import SwiftUI

struct InventoryView: View {
    var body: some View {
        VStack(alignment: HorizontalAlignment.center) {
            TopNavBarView()
            Spacer()
            Text("View to show the inventory")
                .font(.custom("Audiowide-Regular", size: 40))
                .foregroundStyle(Color.peachOrange)
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.outerSpace)
    }
}

#Preview {
    InventoryView()
}
