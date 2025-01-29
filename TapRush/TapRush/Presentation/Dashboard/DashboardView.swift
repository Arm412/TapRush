//
//  DashboardView.swift
//  TapRush
//
//  Created by Adam Mitro on 12/13/24.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("TapRush!")
                    .font(.custom("Audiowide-Regular", size: 70))
                    .foregroundStyle(Color.peachOrange)
                
                Spacer()
                
                NavigationLink(destination: CampaignView()) {
                    Text("Campaign")
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.peachOrange, lineWidth: 5)
                        )
                        .font(.custom("Audiowide-Regular", size: 40))
                        .foregroundStyle(Color.peachOrange)
                        .padding()
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(Color.outerSpace)
        }
    }
}

#Preview {
    DashboardView()
}
