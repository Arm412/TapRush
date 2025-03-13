import SwiftUI

struct TestView: View {
    @State private var flagPosition: CGPoint = CGPoint(x: 400, y: 300)
    @State private var scrollViewID = "scrollViewID"
    
    let scrollWidth: CGFloat = 1000
    let scrollHeight: CGFloat = 1000
    
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            ScrollViewReader { proxy in
                VStack {
                    Image(systemName: "flag.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)
                        .position(flagPosition)
                        .id(scrollViewID) // Make sure the flag has an ID to scroll to
                        .onAppear {
                            // Generate a random position for the flag within the scroll bounds
                            //                            flagPosition = CGPoint(
                            //                                x: CGFloat.random(in: 0..<scrollWidth),
                            //                                y: CGFloat.random(in: 0..<scrollHeight)
                            //                            )
                            
                            // Scroll to the flag position with a slight offset to center it in the view
                            //                            let offset = CGPoint(x: flagPosition.x - 25, y: flagPosition.y - 25)
                            withAnimation {
                                proxy.scrollTo(scrollViewID, anchor: .center) // Scroll to the flag's position
                            }
                        }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
