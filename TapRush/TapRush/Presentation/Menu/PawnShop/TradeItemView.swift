import SwiftUI

struct TradeItemView: View {
    @Binding var gem: GemItem
    @Binding var totalGold: Int
    @State var sellAmount: Int = 0
    @State var calculatedGold: Int = 0
    @State var plusIsTapped = false
    @State var minusIsTapped = false
    
    // Helper function to dynamically scale font size based on the number length
    func dynamicFontSize(for number: Int) -> CGFloat {
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
            .frame(width: 70, height: 90)
            
            Image(systemName: "minus")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .padding()
                .overlay(
                    Circle().stroke(minusIsTapped ? Color.red : Color.peachOrange, lineWidth: 2)
                )
                .foregroundStyle(minusIsTapped ? Color.red : Color.peachOrange)
                .contentShape(Circle())
                .onTapGesture {
                    if (sellAmount - gem.minimumGemIncrement >= 0) {
                        sellAmount -= gem.minimumGemIncrement
                        calculatedGold -= gem.goldPerIncrement
                        $totalGold.wrappedValue -= gem.goldPerIncrement
                        
                        withAnimation(.easeInOut(duration: 0.3)) {
                            minusIsTapped = false
                        }
                    } else {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            minusIsTapped = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                minusIsTapped = false
                            }
                        }
                    }
                }


            Text("\(sellAmount)")
                .font(.custom("Roboto", size: dynamicFontSize(for: sellAmount)))
                .foregroundStyle(.peachOrange)
                .frame(width: 50)

            Image(systemName: "plus")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .padding()
                .overlay(
                    Circle().stroke(plusIsTapped ? Color.red : Color.peachOrange, lineWidth: 2)
                )
                .foregroundStyle(plusIsTapped ? Color.red : Color.peachOrange)
                .contentShape(Circle())
                .onTapGesture {
                    if (sellAmount + gem.minimumGemIncrement <= gem.itemCount) {
                        sellAmount += gem.minimumGemIncrement
                        calculatedGold += gem.goldPerIncrement
                        $totalGold.wrappedValue += gem.goldPerIncrement
                        withAnimation(.easeInOut(duration: 0.3)) {
                            plusIsTapped = false
                        }
                    } else {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            plusIsTapped = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                plusIsTapped = false
                            }
                        }
                    }
                }
            Image(systemName: "arrow.right")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .foregroundStyle(.peachOrange)
                .padding(.leading, 10)

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
    @Previewable @State var total: Int = 0
    TradeItemView(gem: $gem, totalGold: $total)
}
