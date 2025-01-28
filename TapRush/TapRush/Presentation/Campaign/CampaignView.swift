import SwiftUI
import SwiftData

struct CampaignView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var context
    
    @Query var count: [Count]
    
    @State var currentCount: Count = Count(count: 0)
    
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
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.outerSpace)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CampaignView(currentCount: Count(count: 0))
}
