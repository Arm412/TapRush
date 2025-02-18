//
//  TopNavBarView.swift
//  TapRush
//
//  Created by Adam Mitro on 1/28/25.
//

import SwiftUI

struct TopNavBarView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var menuVM: MenuViewModel
    
    var menuHandler: () -> Void = {}
    
    var title: String
    var isMining: Bool = false
    
    var body: some View {
        ZStack(alignment: Alignment.leading) {
            if (isMining) {
                Button(action: {
                    withAnimation {
                        menuHandler()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(Color.peachOrange)
                }
                .padding()
            } else {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(Color.peachOrange)
                }
                .padding()
            }
            HStack {
                Spacer()
                Text(title)
                    .font(.custom("Audiowide-Regular", size: 30))
                    .foregroundStyle(.peachOrange)
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    var menuVM = MenuViewModel()
    
    TopNavBarView(title: "Menu")
        .environmentObject(menuVM)
}
