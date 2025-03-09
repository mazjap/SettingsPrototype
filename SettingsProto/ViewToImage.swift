import SwiftUI

struct ViewToImage<Content: View>: View {
    @State private var generatedImage: UIImage?
    @Environment(\.displayScale) private var displayScale
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        VStack {
            if let generatedImage {
                let img = Image(uiImage: generatedImage)
                img
                
                ShareLink("Export", item: img, preview: SharePreview(Text("Shared Image"), image: img))
            } else {
                Rectangle()
                    .stroke(Color.black, lineWidth: 1)
                
                Text("Generating...")
            }
            
            Button("Retry") {
                render()
            }
        }
        .onAppear {
            render()
        }
    }
    
    @MainActor private func render() {
        let renderer = ImageRenderer(content: content())
        renderer.scale = displayScale
        
        generatedImage = renderer.uiImage
    }
}

#Preview {
    func viewWithLabel(_ label: String) -> some View {
        Text(label.uppercased())
            .bold()
            .padding(8)
            .foregroundStyle(.white)
            .background {
                Circle()
                    .fill(LinearGradient(colors: [Color(red: 0.65, green: 0.67, blue: 0.72), Color(red: 0.53, green: 0.55, blue: 0.59)], startPoint: .top, endPoint: .bottom))
                    .stroke(.white, lineWidth: 2)
            }
    }
    
    return ViewToImage {
        ZStack {
            viewWithLabel("DC")
                .offset(x: -24)
            viewWithLabel("CG")
                .offset(x: -8)
            viewWithLabel("MC")
                .offset(x: 8)
            viewWithLabel("MC")
                .offset(x: 24)
        }
        .frame(width: 88, height: 40)
    }
}
