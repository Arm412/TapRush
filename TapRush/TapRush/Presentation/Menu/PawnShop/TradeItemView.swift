import SwiftUI

struct TradeItemView: View {
    @Binding var gem: GemItem
    @Binding var totalGold: Int
    @Binding var gemCount: SoldGemCounts
    @State var sellAmount: Int = 0
    @State var calculatedGold: Int = 0
    @State var plusIsTapped = false
    @State var minusIsTapped = false
    
    @EnvironmentObject var menuVM: MenuViewModel
    
    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
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
    
    func dynamicPaddingSize() -> CGFloat {
        if screenWidth <= 375 {
            return 15
        } else if screenWidth <= 600 {
            return 25
        } else {
            return 40
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
            .padding(.leading, dynamicPaddingSize())
            
            Spacer()
            
            HStack {
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
//                            $totalGems.wrappedValue -= gem.minimumGemIncrement
                            updateGemCount(type: gem.gemType, amount: gem.minimumGemIncrement * -1)
                            
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
//                            $totalGems.wrappedValue += gem.minimumGemIncrement
                            updateGemCount(type: gem.gemType, amount: gem.minimumGemIncrement)
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
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.peachOrange)
                    .padding(.leading, 10)
            }

            Spacer()
            
            Text("\(calculatedGold)")
                .font(.custom("Roboto", size: dynamicFontSize(for: calculatedGold)))
                .foregroundStyle(.peachOrange)
                .frame(width: 50)
                .padding(.trailing, dynamicPaddingSize())
        }
        .frame(maxWidth: .infinity)
    }
    
    func updateGemCount(type: GemType, amount: Int) {
        if type == .common {
            gemCount.common += amount
        } else if type == .uncommon {
            gemCount.uncommon += amount
        } else if type == .rare {
            gemCount.rare += amount
        } else if type == .legendary {
            gemCount.legendary += amount
        } else if type == .mythical {
            gemCount.mythical += amount
        }
    }
}

#Preview {
    @Previewable @State var gem = GemItem(itemIcon: "emerald", itemCount: 2, itemName: "Emerald", itemDescription: "A rare gem", gemType: .rare)
    @Previewable @State var total: Int = 1000
    @Previewable @State var gemCount = SoldGemCounts()
    
    TradeItemView(gem: $gem, totalGold: $total, gemCount: $gemCount)
}
