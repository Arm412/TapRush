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
                        Image(campaignVM.rocks[index].states[campaignVM.rocks[index].stateIndex])
                            .position(campaignVM.rocks[index].position)
                            .onChange(of:
                                        campaignVM.rocks[index].stateIndex) {
                                if campaignVM.rocks[index].stateIndex == 5 {
                                    campaignVM.startStateUpdateTimer(index: index)
                                }
                            }
                            .onTapGesture {
                                print("Pressed \(campaignVM.rocks[index].stateIndex)")
                                campaignVM.rocks[index].stateIndex += 1
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
        .onAppear {
        }
        .onDisappear {
        }
    }
}

#Preview {
    CampaignView(currentCount: Count(count: 0))
}
