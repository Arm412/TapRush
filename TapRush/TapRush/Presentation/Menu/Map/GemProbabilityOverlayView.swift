//
//  GemProbabilityOverlayView.swift
//  TapRush
//
//  Created by Adam Mitro on 4/14/25.
//

import SwiftUI

struct GemProbabilityOverlayView: View {
    let geoHeight: CGFloat
    let geoWidth: CGFloat
    let mineGemProbabilityList: [GemType: Double]
    let mineNoGemProbability: Double
    
    let gemOrder: [GemType] = [.common, .uncommon, .rare, .legendary, .mythical]
    
    let columns: [GridItem] = [
        GridItem(.flexible(maximum: UIScreen.main.bounds.width/2)),
        GridItem(.flexible(maximum: UIScreen.main.bounds.width/2))
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(Strings.gemProbabilities)
                .font(.custom("Audiowide-Regular", size: 25))
                .foregroundStyle(.white)
            LazyVGrid(columns: columns, spacing: 30) {
                ForEach(Array(gemOrder), id: \.self) { gem in
                    if (mineGemProbabilityList[gem] ?? 0 > 0) {
                        HStack {
                            Image(GemHelpers.getGemIcon(for: gem))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            
                            Text(": \((mineGemProbabilityList[gem] ?? 0) * 100, specifier: "%.1f")%")
                                .foregroundStyle(.white)
                        }
                    }
                }
                if (mineNoGemProbability > 0) {
                    HStack {
                        Image("nothing")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.red)
                        Text(": \(mineNoGemProbability * 100, specifier: "%.1f")%")
                            .foregroundStyle(.white)
                    }
                }
            }
            Spacer()
        }
        .padding()
        .frame(width: geoWidth, height: geoHeight * 0.4)
    }
}

#Preview {
    let gemProbabilities: [GemType: Double] = [
        .common: 0.2,
        .uncommon: 0.2,
        .rare: 0.2,
        .legendary: 0.2,
        .mythical: 0.1
    ]
    let noProbability: Double = 0.1
    let geoWidth: CGFloat = 400
    let geoHeight: CGFloat = 400
    
    
    GemProbabilityOverlayView(geoHeight: geoHeight, geoWidth: geoWidth, mineGemProbabilityList: gemProbabilities, mineNoGemProbability: noProbability)
}
