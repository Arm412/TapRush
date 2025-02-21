//
//  InventoryView.swift
//  TapRush
//
//  Created by Adam Mitro on 1/28/25.
//

import SwiftUI

struct InventoryView: View {
    @EnvironmentObject private var menuVM: MenuViewModel
    
    let columnsSmall: [GridItem] = [
        GridItem(.flexible(maximum: 150)),
        GridItem(.flexible(maximum: 150)),
    ]
    
    let columnsLarge: [GridItem] = [
        GridItem(.flexible(maximum: 110)),
        GridItem(.flexible(maximum: 110)),
        GridItem(.flexible(maximum: 110))
    ]
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: HorizontalAlignment.center) {
                TopNavBarView(title: Strings.inventory)
                
                ScrollView {
                    LazyVGrid(columns: geo.size.width < 400 ? columnsSmall : columnsLarge, spacing: 20) {
                        ForEach(0..<16) { _ in
                            InventoryItemView()
                        }
                    }
                    .frame(width: geo.size.width)
                    .padding(.bottom, 20)
                }
                .frame(width: geo.size.width, height: geo.size.height > 0 ? geo.size.height - 100 : 0)
                .background(Color.outerSpace)
            }
            .navigationBarBackButtonHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.outerSpace)
        }
    }
}

#Preview {
    var viewModel = MenuViewModel()
    
    InventoryView()
        .environmentObject(viewModel)
}
