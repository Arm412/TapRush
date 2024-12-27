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
    
    var body: some View {
        VStack {
            ButtonCountView(updateCount: $currentCount)
        }
        .onAppear {
            if let firstCount = count.first {
                // If a count exists, bind it to `count`
                currentCount = firstCount
            } else {
                context.insert(currentCount)
                do {
                    try context.save()
                } catch {
                    print("An error occurred: \(error)")
                }
            }
        }
        .onDisappear {
            print("End Count... Saving... \(currentCount.count)")
            do {
                try context.save()
            } catch {
                print("An error occurred: \(error)")
            }
        }
    }
}

#Preview {
    CampaignView(currentCount: Count(count: 0))
}
