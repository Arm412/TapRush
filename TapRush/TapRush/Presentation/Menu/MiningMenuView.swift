import SwiftUI

struct MiningMenuView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var selectedMine: String = "Pebblebrook Quarry"
    
    @EnvironmentObject private var menuVM: MenuViewModel
    @EnvironmentObject private var navigationVM: NavigationViewModel
    
    let columns: [GridItem] = [
        GridItem(.flexible(maximum: 175)),
        GridItem(.flexible(maximum: 175))
    ]
    
    var body: some View {
        VStack {
            TopNavBarView(title: Strings.menu)
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
                Text(selectedMine)
                    .foregroundStyle(.peachOrange)
                    .font(.custom("Audiowide-Regular", size: 25))
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
                .onTapGesture {
                    navigationVM.navigateTo(screen: .mining)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.outerSpace)
        .navigationBarBackButtonHidden(true)
        .environmentObject(menuVM)
        
    }
}

#Preview {
    var navigationViewModel = NavigationViewModel()
    var menuViewModel = MenuViewModel()
    
    MiningMenuView()
        .environmentObject(navigationViewModel)
        .environmentObject(menuViewModel)
}
