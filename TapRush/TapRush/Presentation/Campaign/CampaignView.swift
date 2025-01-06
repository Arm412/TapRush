//
//  CampaignView.swift
//  TapRush
//
//  Created by Adam Mitro on 12/13/24.
//

import SwiftUI
import SwiftData

struct CampaignView: View {
    @Environment(\.modelContext) private var context
    
    @Query var count: [Count]
    
    @State var currentCount: Count = Count(count: 0)
    
    @State var rocks: [Rock] = []
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "house.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Color.peachOrange)
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
                Image(systemName: "storefront.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Color.peachOrange)
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
            GeometryReader { geo in
                ZStack {
                    ForEach(rocks.indices, id: \.self) { index in
                        Image(rocks[index].states[rocks[index].stateIndex])
                            .position(rocks[index].position)
                            .onTapGesture {
                                print("Pressed \(rocks[index].id)")
                                rocks[index].stateIndex += 1
                            }
                    }
                }
                .onAppear {
                    var validCoordinate = false
                    let screenWidth = geo.size.width
                    let widthLimit = screenWidth - 100
                    let screenHeight = geo.size.height
                    let heightLimit = screenHeight - 100
                    var rockX = 0
                    var rockY = 0
                    
                    for i in 1...10 {
                        while !validCoordinate {
                            rockX = Int.random(in: 50 ..< Int(widthLimit))
                            rockY = Int.random(in: 50 ..< Int(heightLimit))
                            var reset = false
                            for rock in rocks {
                                let rangeX = (rock.position.x - 75) ..< (rock.position.x + 75)
                                let rangeY = (rock.position.y - 75) ..< (rock.position.y + 75)
                                if rangeX.contains(CGFloat(rockX)) && rangeY.contains(CGFloat(rockY)) {
                                    reset = true
                                    break
                                }
                            }
                            if !reset {
                                validCoordinate = true
                            }
                        }
                        print("Add rock \(rockX), \(rockY)")
                        rocks.append(Rock(id: UUID(), position: CGPoint(x: rockX, y: rockY), rockType: .beginner))
                        validCoordinate = false
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.outerSpace)
        .onAppear {
        }
        .onDisappear {
        }
    }
}

//func getCoordinate(geo: GeometryProxy, rocks: [Rock]) -> CGPoint {
//    var validCoordinate = false
//    let screenWidth = geo.size.width
//    let widthLimit = screenWidth - 100
//    let screenHeight = geo.size.height
//    let heightLimit = screenHeight - 100
//    var rockX = 0
//    var rockY = 0
//    
//    for i in 1...5 {
//        while !validCoordinate {
//            rockX = Int.random(in: 50 ..< Int(widthLimit))
//            rockY = Int.random(in: 50 ..< Int(heightLimit))
//            for rock in rocks {
//                let rangeX = (rock.position.x - 50) ..< (rock.position.x + 50)
//                let rangeY = (rock.position.y - 50) ..< (rock.position.y + 50)
//                if rangeX.contains(CGFloat(rockX)) && rangeY.contains(CGFloat(rockY)) {
//                    break
//                }
//            }
//            validCoordinate = true
//        }
//                rocks.append(Rock(id: UUID(), position: CGPoint(x: rockX, y: rockY), rockType: .beginner))
//    }
//}

#Preview {
    CampaignView(currentCount: Count(count: 0))
}
