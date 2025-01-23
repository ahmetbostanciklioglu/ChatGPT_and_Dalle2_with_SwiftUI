import SwiftUI


struct MessageIndicatorView: View {
    var body: some View {
        HStack {
            DotView()
            DotView(delay: 0.2)
            DotView(delay: 0.4)
        }
        .padding(12)
        .background(.gray.opacity(0.25))
        .cornerRadius(25)
    }
}


#Preview {
    MessageIndicatorView()
}
