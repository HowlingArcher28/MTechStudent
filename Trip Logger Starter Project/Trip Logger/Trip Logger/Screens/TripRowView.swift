import SwiftUI

struct TripRowView: View {
    let title: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "mappin.and.ellipse")
                .foregroundStyle(Theme.accent)
                .imageScale(.large)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                Text("Open map and journal")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(Color.gray.opacity(0.5))
        }
        .padding(.vertical, Spacing.rowV)
    }
}

#Preview {
    List {
        TripRowView(title: "Summer Road Trip")
    }
}
