import SwiftUI

struct DotView: View {
    
    @State var scale: CGFloat = 0.5
    @State var delay: Double = 0
    
    var body: some View {
        Circle()
            .frame(width: 7, height: 7)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.easeInOut.repeatForever().delay(delay)) {
                    self.scale = 1
                }
            }
    }
}
