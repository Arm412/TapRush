//
//  TopNavBarView.swift
//  TapRush
//
//  Created by Adam Mitro on 1/28/25.
//

import SwiftUI

struct TopNavBarView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var campaignVM = CampaignViewModel()
    
    var body: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.backward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Color.peachOrange)
            }
            Spacer()
            VStack {
                HStack {
                    Image("purpEmerald1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    
                    Text("\(campaignVM.gemCount.common)")
                        .foregroundStyle(Color.peachOrange)
                        .font(.system(size: 25))
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .overlay(
            Rectangle()
                .frame(height: 2)
                .foregroundColor(Color.peachOrange)
                .padding(.top, 48),
            alignment: .bottom
        )
    }
}

#Preview {
    TopNavBarView()
}
