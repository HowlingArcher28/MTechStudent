import SwiftUI

struct BackgroundView: View {
    @State private var angle: Angle = .degrees(0)

    var body: some View {
        ZStack {
            AngularGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.98, green: 0.90, blue: 1.0),
                    Color(red: 0.90, green: 0.96, blue: 1.0),
                    Color(red: 0.92, green: 1.00, blue: 0.92),
                    Color(red: 0.86, green: 0.94, blue: 1.00),
                    Color(red: 0.96, green: 0.88, blue: 1.00)
                ]),
                center: .center,
                angle: angle
            )
            .animation(.linear(duration: 30).repeatForever(autoreverses: false), value: angle)
            .onAppear { angle = .degrees(360) }

            NoiseOverlay()
                .blendMode(.overlay)
                .opacity(0.06)
        }
    }
}

private struct NoiseOverlay: View {
    var body: some View {
        Canvas { ctx, size in
            let noiseSize: CGFloat = 80
            for x in stride(from: 0, to: size.width, by: noiseSize) {
                for y in stride(from: 0, to: size.height, by: noiseSize) {
                    let rect = CGRect(x: x, y: y, width: noiseSize, height: noiseSize)
                    let gray = Double.random(in: 0.4...0.6)
                    ctx.fill(Path(rect), with: .color(Color(white: gray)))
                }
            }
        }
    }
}
