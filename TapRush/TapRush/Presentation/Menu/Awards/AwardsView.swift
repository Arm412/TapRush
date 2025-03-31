//
//  AwardsView.swift
//  TapRush
//
//  Created by Adam Mitro on 1/27/25.
//

import SwiftUI

struct AwardsView: View {
    var body: some View {
        VStack(alignment: HorizontalAlignment.center) {
            TopNavBarView(foregroundColor: .peachOrange, title: "Awards")
            Spacer()
            Text("View to display achievements")
                .font(.custom("Audiowide-Regular", size: 40))
                .foregroundStyle(Color.peachOrange)
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.outerSpace)
    }
}

#Preview {
    AwardsView()
}
