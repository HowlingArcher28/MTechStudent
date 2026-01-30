import SwiftUI

public struct ProductCard: View {
    public let title: String
    public let price: Double
    public let color: Color

    public init(title: String, price: Double, color: Color) {
        self.title = title
        self.price = price
        self.color = color
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(color.gradient.opacity(0.25))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(color.opacity(0.35), lineWidth: 1)
                )

            VStack(spacing: 6) {
                Image(systemName: "bag")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(color)
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxHeight: .infinity, alignment: .center)
            .padding()
        }
    }
}
