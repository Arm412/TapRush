import SwiftUI

struct MiningMenuView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var selectedMine: Mine
    
    @State private var showPowerupModal: Bool = false
    
    @EnvironmentObject private var menuVM: MenuViewModel
    @EnvironmentObject private var navigationVM: NavigationViewModel
    
    let columns: [GridItem] = [
        GridItem(.flexible(maximum: 175)),
        GridItem(.flexible(maximum: 175))
    ]
    
    var body: some View {
        ZStack {
            VStack {
                TopNavBarView(foregroundColor: .peachOrange, title: Strings.menu)
                    .environmentObject(menuVM)
                
                VStack {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(menuVM.miningMenuNavButtons) { item in
                            VStack {
                                Image(systemName: item.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(.peachOrange)
                                Text(item.name)
                                    .foregroundStyle(.peachOrange)
                                    .font(.custom("Audiowide-Regular", size: 18))
                                    .frame(maxWidth: .infinity)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(EdgeInsets(top: 20, leading: 5, bottom: 20, trailing: 5))
                            .background(item.primaryColor)
                            .border(.peachOrange, width: 2)
                            .cornerRadius(5)
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                            .onTapGesture {
                                navigationVM.navigateTo(screen: item.destination)
                            }
                        }
                    }
                }
                Spacer()
                VStack {
                    Text(Strings.currentDestination)
                        .foregroundStyle(.peachOrange)
                        .font(.custom("Audiowide-Regular", size: 25))
                    Text(selectedMine.name.rawValue)
                        .foregroundStyle(.peachOrange)
                        .font(.custom("Audiowide-Regular", size: 25))
                    Button(action: {
                        showPowerupModal = true
                    }) {
                        HStack {
                            Text(Strings.toTheMines)
                                .font(.custom("Audiowide-Regular", size: 25))
                                .foregroundStyle(.peachOrange)
                            Image("pickaxeAnimation5")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.peachOrange)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.outerSpace)
                        .border(.peachOrange, width: 2)
                        .cornerRadius(5)
                        .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
                    }
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.outerSpace)
            .navigationBarBackButtonHidden(true)
            .environmentObject(menuVM)
            
            if(showPowerupModal) {
                PowerupModalView(closeAction: {
                    showPowerupModal.toggle()
                })
                .animation(.easeInOut(duration: 0.3), value: showPowerupModal)
                .environmentObject(navigationVM)
            }
        }
    }
}

#Preview {
    var navigationViewModel = NavigationViewModel()
    var menuViewModel = MenuViewModel()
    
    @State var mine = menuViewModel.mineList[0]
    
    MiningMenuView(selectedMine: $mine)
        .environmentObject(navigationViewModel)
        .environmentObject(menuViewModel)
}
