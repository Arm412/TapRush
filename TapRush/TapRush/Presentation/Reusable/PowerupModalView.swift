//
//  PowerupModalView.swift
//  TapRush
//
//  Created by Adam Mitro on 6/1/25.
//

import SwiftUI

struct PowerupModalView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack {
                    Text("Choose which powerups to activate:")
                        .font(.custom("Audiowide-Regular", size: 20))
                        .foregroundStyle(Color.black)
                        .frame(maxWidth: .infinity)
                    HStack {
                        
                    }
                }
                Spacer()
            }
        }
        .background(Color.black.opacity(0.2))
    }
}

#Preview {
    PowerupModalView()
}
