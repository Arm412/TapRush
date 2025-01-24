//
//  CampaignView.swift
//  TapRush
//
//  Created by Adam Mitro on 12/13/24.
//

import SwiftUI
import SwiftData

struct CampaignView: View {
    @Environment(\.modelContext) private var context
    
    @Query var count: [Count]
    
    @State var currentCount: Count = Count(count: 0)
    
    @State private var lastUpdate = Date()
    
    @StateObject private var campaignVM = CampaignViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "house.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Color.peachOrange)
                Spacer()
                VStack {
                    HStack {
                        Image("purpEmerald1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        
                        Text("\(currentCount.count)")
                            .foregroundStyle(Color.peachOrange)
                            .font(.system(size: 25))
                    }
                }
                Spacer()
                Image(systemName: "storefront.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Color.peachOrange)
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
            Spacer()
            GeometryReader { geo in
                ZStack {
                    ForEach(campaignVM.rocks.indices, id: \.self) { index in
                        if !campaignVM.rocks[index].isDepleted {
                            Image(campaignVM.rocks[index].states[campaignVM.rocks[index].stateIndex])
                                .position(campaignVM.rocks[index].position)
                                .onTapGesture {
                                    print("Pressed \(campaignVM.rocks[index].stateIndex)")
                                    campaignVM.rocks[index].stateIndex += 1
                                    if campaignVM.rocks[index].stateIndex == campaignVM.rocks[index].states.count {
                                        campaignVM.rocks[index].isDepleted = true
                                    }
                                }
                        } else {
                            if (!campaignVM.rocks[index].dustSettled) {
                                let dustCloud = campaignVM.rocks[index].dust
                                Image(dustCloud.dustCloudSprites[dustCloud.spriteIndex])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .position(campaignVM.rocks[index].position)
                                    .onAppear() {
                                        campaignVM.startStateUpdateTimer(index: index)
                                    }
                            } else {
                                Image(campaignVM.rocks[index].gemSprites[0])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .position(campaignVM.rocks[index].position)
                                    .onTapGesture {
                                        campaignVM.rocks[index] = campaignVM.createRock()
                                        currentCount.count += 1
                                    }
                            }
                        }
                    }
                }
                .onAppear {
                    campaignVM.initRocks(geo: geo)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.outerSpace)
    }
}

#Preview {
    CampaignView(currentCount: Count(count: 0))
}
