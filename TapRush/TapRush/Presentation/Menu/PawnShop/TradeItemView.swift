import SwiftUI

struct TradeItemView: View {
    @Binding var gem: GemItem
    @State var sellAmount: Int64 = 0
    @State var calculatedGold: Int64 = 0
    
    // Helper function to dynamically scale font size based on the number length
    func dynamicFontSize(for number: Int64) -> CGFloat {
        let length = String(number).count
        switch length {
        case 1:
            return 25
        case 2:
            return 23
        case 3:
            return 20
        default:
            return 18
        }
    }
    
    var body: some View {
        HStack {
            ZStack {
                Image(gem.itemIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)

                VStack {
                    Spacer()
                    HStack {
                        Text("x\(gem.itemCount)")
                            .font(.custom("Roboto", size: 20))
                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                            .foregroundStyle(.peachOrange)
                        Spacer()
                    }
                }
            }
            .frame(width: 90, height: 90)

            Image(systemName: "minus")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .padding()
                .border(.peachOrange, width: 2)
                .foregroundStyle(.peachOrange)
                .contentShape(Rectangle())
                .onTapGesture {
                    if (sellAmount - 1 >= 0) {
                        sellAmount -= 1
                        calculatedGold -= 10
                    }
                }

            Text("\(sellAmount)")
                .font(.custom("Roboto", size: dynamicFontSize(for: sellAmount)))
                .foregroundStyle(.peachOrange)
                .frame(width: 50)
                .padding()

            Image(systemName: "plus")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .padding()
                .border(.peachOrange, width: 2)
                .foregroundStyle(.peachOrange)
                .contentShape(Rectangle())
                .onTapGesture {
                    if (sellAmount + 1 <= gem.itemCount) {
                        sellAmount += 1
                        calculatedGold += 10
                    }
                }

            Text("\(calculatedGold)")
                .font(.custom("Roboto", size: dynamicFontSize(for: calculatedGold)))
                .foregroundStyle(.peachOrange)
                .frame(width: 50)
                .padding()
        }
    }
}

#Preview {
    @Previewable @State var gem = GemItem(itemIcon: "emerald", itemCount: 2, itemName: "", itemDescription: "", gemType: .rare)
    TradeItemView(gem: $gem)
}
