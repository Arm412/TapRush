//
//  PowerupModalView.swift
//  TapRush
//
//  Created by Adam Mitro on 6/1/25.
//

import SwiftUI

struct PowerupModalView: View {
    var powerupList: [any Powerup]
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack {
                    Text("Choose which powerups to activate:")
                        .font(.custom("Audiowide-Regular", size: 20))
                        .foregroundStyle(Color.black)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 15)
                    ForEach(powerupList.indices, id: \.self) { index in
                        let powerup = powerupList[index]
                        HStack {
                            Spacer()
                            HStack {
                                Image(systemName: "questionmark")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.white)
                                    .frame(width: 45, height: 45)
                                    .padding()
                                    .border(.gray, width: 2)
                                Text(powerup.name)
                                    .font(.custom("Audiowide-Regular", size: 15))
                                    .foregroundStyle(Color.black)
                                    .padding(.bottom, 5)
                                    .frame(width: 90)
                            }
                            Spacer()
                        }
                    }

                }
                Spacer()
            }
        }
        .background(Color.black.opacity(0.2))
    }
}

#Preview {
    let powerupList: [Powerup] = [AutoCollect(), BlastStrike(), PowerStrike()]
    
    PowerupModalView(powerupList: powerupList)
}
