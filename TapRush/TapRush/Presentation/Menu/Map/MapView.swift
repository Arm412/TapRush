//
//  MapView.swift
//  TapRush
//
//  Created by Adam Mitro on 1/27/25.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        VStack(alignment: HorizontalAlignment.center) {
            TopNavBarView()
            Spacer()
            Text("View to display the mine destinations")
                .font(.custom("Audiowide-Regular", size: 40))
                .foregroundStyle(Color.peachOrange)
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.outerSpace)
    }
}

#Preview {
    MapView()
}
