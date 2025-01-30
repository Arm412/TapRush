//
//  MineView.swift
//  TapRush
//
//  Created by Adam Mitro on 1/24/25.
//

import SwiftUI

struct MineView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var campaignVM = CampaignViewModel()
    
    var body: some View {
        VStack {
            TopNavBarView()
            
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
                                        campaignVM.updateGemCount(campaignVM.rocks[index].gemType)
                                    }
                            }
                        }
                    }
                }
                .onAppear {
                    campaignVM.initRocks(geo: geo)
                }
                .onDisappear {
                    campaignVM.save()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.outerSpace)
            .navigationBarBackButtonHidden(true)
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.outerSpace)
    }
}

#Preview {
    MineView()
}
