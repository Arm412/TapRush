import SwiftUI
import SwiftData

struct CampaignView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var context
    
    @Query var count: [Count]
    
    @State var currentCount: Count = Count(count: 0)
    
    @StateObject private var campaignVM = CampaignViewModel()
    
    let columns: [GridItem] = [
            GridItem(.flexible(minimum: 50)),
            GridItem(.flexible(minimum: 10))
        ]
    
    var body: some View {
        NavigationView { // Wrap the entire view in a NavigationView
            VStack {
                // Top navigation bar
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
                    Spacer()
                    NavigationLink(destination: CampaignStoreView()) {
                        Image(systemName: "storefront.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color.peachOrange)
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
                
                Spacer()
                
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 50) {
                            ForEach(campaignVM.campaignDashboardNavButtons) { item in
                                Text(item.name)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(8)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                        .padding()
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.outerSpace)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CampaignView(currentCount: Count(count: 0))
}
