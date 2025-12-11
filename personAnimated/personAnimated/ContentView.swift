import SwiftUI

enum ImageType: Int {
    case person
    case person2
    case person3
    
    var imageName: String {
        switch self {
        case .person: "person"
        case .person2: "person.2"
        case .person3: "person.3"
        }
    }
}

struct ContentView: View {
    @State private var currentImage: ImageType = .person
    @State private var isRunning = true

    @Namespace private var symbolNamespace

    var body: some View {
        VStack(spacing: 24) {
            VStack {
                
                imageView(type: .person)
                
                imageView(type: .person2)
                
                imageView(type: .person3)
            }

            .frame(height: 220)
            .frame(maxWidth:.infinity)

        }
        .padding()
        .onTapGesture { isRunning.toggle() }
        .task {
            while !Task.isCancelled {
                if isRunning {
                    try? await Task.sleep(for: .seconds(1))
                    await swapToNextSymbol()
                } else {
                    try? await Task.sleep(for: .seconds(0.1))
                }
            }
        }
    }
    
    @ViewBuilder
    private func imageView(type: ImageType) -> some View {
        if currentImage == type {
            Image(systemName: type.imageName)
                .font(.system(size: 120, weight: .regular))
                .foregroundStyle(.tint)
                .matchedGeometryEffect(id: "viewID", in: symbolNamespace)
                .frame(height: 220)
        } else {
            Color.clear
                .frame(height: 220)
        }
    }
    
    
    
    

    private func swapToNextSymbol() async {
        withAnimation(.spring(response: 0.36, dampingFraction: 0.78, blendDuration: 0.1)) {
            switch currentImage {
            case .person:
                currentImage = .person2
            case .person2:
                currentImage = .person3
            case .person3:
                currentImage = .person
            }        }

        try? await Task.sleep(for: .milliseconds(360))
    }
}

#Preview { ContentView() }
