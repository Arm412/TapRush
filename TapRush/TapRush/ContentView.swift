//
//  ContentView.swift
//  TapRush
//
//  Created by Adam Mitro on 12/13/24.
//

import SwiftUI

struct ContentView: View {
    @State var counter: Int = 0
    @State var isPressed: Bool = false
    @State var pointsPerClick = 1
    @State private var numbers: [SlidingNumber] = []
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("\(counter)")
                .font(Font.system(size: 50))
                .foregroundStyle(Color.lightningYellow)
            
            Spacer()
            
            ZStack {
                ForEach(numbers.indices, id: \.self) { index in
                    let number = numbers[index]
                    Text("+\(pointsPerClick)")
                        .font(.title)
                        .foregroundColor(Color.perano)
                        .opacity(number.isVisible ? 1 : 0)  // Fade in/out effect
                        .offset(x: number.position.x, y: number.position.y)
                        .animation(.easeInOut(duration: 2), value: number.position)  // Apply animation to position change
                        .onAppear {
                            // Trigger the sliding and fading effect after text appears
                            withAnimation(.easeInOut(duration: 2).delay(0.5)) {
                                // Update the position by modifying the state directly
                                var updatedNumber = number
                                updatedNumber.position.y -= 400  // Move upwards
                                updatedNumber.position.x = CGFloat.random(in: -50...50)
                                updatedNumber.isVisible = false  // Fade out
                                
                                // Update the texts array with the modified text
                                numbers[index] = updatedNumber
                            }
                        }
                }
                Button(action: increment) {
                    ZStack {
                        if isPressed {
                            Color.lightningYellow
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.blush.opacity(0.7), lineWidth: 10)
                                )
                        } else {
                            Color.lightningYellow
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.blush, lineWidth: 10)
                                )
                        }
                        
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color.blush)
                    }
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding()
                    .shadow(color: Color.shipCove, radius: 1.0, x: 0, y: isPressed ? 0 : 5)
                    .offset(y: isPressed ? 5 : 0)
                }
                .buttonStyle(PlainButtonStyle())
                .simultaneousGesture(DragGesture(minimumDistance: 0).onChanged { _ in
                    isPressed = true
                }.onEnded { _ in
                    isPressed = false
                })
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color.arapawa)
    }
    
    func increment() {
        let newNumber = SlidingNumber(id: UUID(), position: CGPoint(x: CGFloat.random(in: -150...150), y: CGFloat.random(in: 100...200)))
        numbers.append(newNumber)
        counter += 1
    }
}

struct SlidingNumber: Identifiable {
    let id: UUID
    var position: CGPoint
    var isVisible: Bool = true
}

#Preview {
    ContentView()
}
