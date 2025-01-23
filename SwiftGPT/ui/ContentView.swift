import SwiftUI

struct ContentView: View {
    
    init(){
        UITabBar.appearance().unselectedItemTintColor = .gray
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    var body: some View {
        NavigationView {
            TabView {
                ChatGPTView().tabItem {
                    Label("CHAT BOT", systemImage: "ellipses.bubble")
                }
                DalleView().tabItem {
                    Label("DALL-E 2", systemImage: "paintbrush")
                }
            }
            .tint(.accentColor)
        }
    }
}



#Preview {
    ContentView()
}
