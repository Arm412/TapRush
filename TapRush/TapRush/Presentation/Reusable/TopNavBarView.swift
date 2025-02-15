//
//  TopNavBarView.swift
//  TapRush
//
//  Created by Adam Mitro on 1/28/25.
//

import SwiftUI

struct TopNavBarView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var campaignVM: CampaignViewModel
    
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
                    HStack {
                        Image("purpEmerald1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text("\(campaignVM.gems.common)")
                            .foregroundStyle(Color.peachOrange)
                            .font(.system(size: 20))
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                    HStack {
                        Text("UC")
                            .frame(width: 40, height: 40)
                            .background(.green)
                        Text("\(campaignVM.gems.uncommon)")
                            .foregroundStyle(Color.peachOrange)
                            .font(.system(size: 20))
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                    HStack {
                        Text("Rare")
                            .frame(width: 40, height: 40)
                            .background(.blue)
                        Text("\(campaignVM.gems.rare)")
                            .foregroundStyle(Color.peachOrange)
                            .font(.system(size: 20))
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
                HStack {
                    HStack {
                        Text("L")
                            .frame(width: 40, height: 40)
                            .background(.yellow)
                        Text("\(campaignVM.gems.legendary)")
                            .foregroundStyle(Color.peachOrange)
                            .font(.system(size: 20))
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                    HStack {
                        Text("Myth")
                            .frame(width: 40, height: 40)
                            .background(.purple)
                        Text("\(campaignVM.gems.mythical)")
                            .foregroundStyle(Color.peachOrange)
                            .font(.system(size: 20))
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                    HStack {
                        Text("Gold")
                            .frame(width: 40, height: 40)
                        Text("\(campaignVM.gold.count)")
                            .foregroundStyle(Color.peachOrange)
                            .font(.system(size: 20))
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
            }
            .foregroundStyle(Color.black)
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
    var campaignVM = CampaignViewModel()
    
    TopNavBarView()
        .environmentObject(campaignVM)
}
