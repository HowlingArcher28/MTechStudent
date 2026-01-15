import SwiftUI

struct SectionHeaderView: View {
    var title: String
    var subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.primary)
                .padding(.horizontal)
            Text(subtitle)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .padding(.horizontal)
        }
        .padding(.top)
    }
}

#Preview {
    SectionHeaderView(title: "Your Trips", subtitle: "Tap to open the map and journal")
}
