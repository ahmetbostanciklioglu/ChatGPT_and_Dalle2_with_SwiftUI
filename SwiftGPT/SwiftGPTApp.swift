import SwiftUI

@main
struct SwiftGPTApp: App {
    
    let dalleViewModel = DalleViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dalleViewModel)
                
        }
    }
}
