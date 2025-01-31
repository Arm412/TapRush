import SwiftUI

struct CampaignView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var selectedMine: String = "Pebblebrook Quarry"
    
    @StateObject private var campaignVM = CampaignViewModel()
    
    let columns: [GridItem] = [
        GridItem(.flexible(maximum: 150)),
        GridItem(.flexible(maximum: 150))
        ]
    
    var body: some View {
        NavigationStack {
            VStack {
                TopNavBarView()
                    .environmentObject(campaignVM)
                
                VStack {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(campaignVM.campaignDashboardNavButtons) { item in
                            NavigationLink(destination: item.destination.environmentObject(campaignVM)) {
                                VStack {
                                    Image(systemName: item.icon)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .foregroundStyle(.peachOrange)
                                    Text(item.name)
                                        .foregroundStyle(.peachOrange)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(item.primaryColor)
                                .border(.peachOrange, width: 2)
                                .cornerRadius(5)
                                .padding()
                            }
                        }
                    }
                }
                Spacer()
                VStack {
                    Text("Current Destination:")
                        .foregroundStyle(.peachOrange)
                        .font(.custom("Audiowide-Regular", size: 25))
                    Text(selectedMine)
                        .foregroundStyle(.peachOrange)
                        .font(.custom("Audiowide-Regular", size: 25))
                    NavigationLink(destination: MineView().environmentObject(campaignVM)) {
                        HStack {
                            Text("To the Mines!")
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
                        .padding(EdgeInsets(top: 20, leading: 50, bottom: 20, trailing: 50))
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.outerSpace)
        }
        .environmentObject(campaignVM)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
//    CampaignView(currentCount: Count(count: 0))
}
