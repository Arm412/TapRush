//
//  MapView.swift
//  TapRush
//
//  Created by Adam Mitro on 1/27/25.
//

import SwiftUI

struct MapView: View {
    @EnvironmentObject var menuVM: MenuViewModel
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.center) {
            TopNavBarView(title: "Maps")
            HStack {
                Image(systemName: "arrow.backward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Color.peachOrange)
                Image(systemName: "arrow.forward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Color.peachOrange)
            }
            Image("worldMap4")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 200)
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.outerSpace)
    }
}

#Preview {
    MapView()
}
