import SwiftUI

struct CampaignView: View {
    @Environment(\.presentationMode) var presentationMode
//    @Environment(\.modelContext) private var context
    
    @State var selectedMine: String = "Pebblebrook Quarry"
    
    @StateObject private var campaignVM = CampaignViewModel()
    
    let columns: [GridItem] = [
        GridItem(.flexible(maximum: 150)),
        GridItem(.flexible(maximum: 150))
        ]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "house.fill")
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
                            
//                            Text("\(currentCount.count)")
//                                .foregroundStyle(Color.peachOrange)
//                                .font(.system(size: 25))
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
                
                VStack {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(campaignVM.campaignDashboardNavButtons) { item in
                            NavigationLink(destination: item.destination) {
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
                    NavigationLink(destination: MineView()) {
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
            .onAppear(perform: {
                campaignVM.getGemCount()
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.outerSpace)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
//    CampaignView(currentCount: Count(count: 0))
}
