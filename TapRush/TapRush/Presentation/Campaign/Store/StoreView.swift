//
//  CampaignStoreView.swift
//  TapRush
//
//  Created by Adam Mitro on 1/23/25.
//

import SwiftUI
import SwiftData

struct StoreView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var context
    
    @Query var count: [Count]
    
    @State var currentCount: Count = Count(count: 0)
    @StateObject private var campaignVM = CampaignViewModel()
    
    var body: some View {
        VStack {
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
                        
                        Text("\(currentCount.count)")
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
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.outerSpace)
    }
}

#Preview {
    let mockCount = Count(count: 5)
    
    StoreView()
}
