import SwiftUI

struct TestView: View {
    @State private var isMenuOpen = false
    @Namespace private var menuNamespace
    
    var body: some View {
        ZStack {
            // Main content
            VStack {
                Text("Main Content")
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
            }
            .offset(x: isMenuOpen ? 250 : 0)  // Move the content when menu is open
            .animation(.easeInOut(duration: 0.3), value: isMenuOpen) // Animate content
            
            // Menu
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isMenuOpen.toggle()
                        }
                    }) {
                        Text("Close")
                            .padding()
                            .foregroundColor(.white)
                    }
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(10)
                }
                Spacer()
                // Menu content goes here
                Text("Menu Content")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
            }
            .frame(width: 250)
            .background(Color.blue)
            .offset(x: isMenuOpen ? 0 : -250)  // Move the menu in from the left
            .animation(.easeInOut(duration: 0.3), value: isMenuOpen) // Animate menu
            .edgesIgnoringSafeArea(.vertical)
            
            // Menu Button to trigger open/close
            Button(action: {
                withAnimation {
                    isMenuOpen.toggle()
                }
            }) {
                Image(systemName: "line.horizontal.3")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .padding()
            }
            .position(x: 30, y: 30) // Menu button in top-left corner
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
