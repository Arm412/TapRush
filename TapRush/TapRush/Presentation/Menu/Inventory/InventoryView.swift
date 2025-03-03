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
                
                HStack {
                    Spacer()
                    Text("\(menuVM.inventory.getTotalInventoryCount())/200")
                        .foregroundStyle(.white)
                        .font(.custom("Roboto", size: 25))
                        .padding()
                    Spacer()
                    
                    HStack {
                        Image("gold")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text("x\(menuVM.inventory.goldCount)")
                            .font(.custom("Roboto", size: 25))
                            .foregroundStyle(.white)
                    }
                    .padding()
                    
                    Spacer()
                }
                
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 2)
                    .frame(maxWidth: .infinity)
                
                ScrollView {
                    LazyVGrid(columns: geo.size.width < 400 ? columnsSmall : columnsLarge, spacing: 20) {
                        ForEach($menuVM.inventory.gemList) { item in
                            InventoryItemView(gemItem: item)
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
