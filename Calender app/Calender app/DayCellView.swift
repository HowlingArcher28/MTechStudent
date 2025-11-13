import SwiftUI

struct DayCellView: View {
    let date: Date
    let isCurrentMonth: Bool
    let isToday: Bool
    let isSelected: Bool
    let eventCount: Int

    private var dayNumber: String {
        String(Calendar.current.component(.day, from: date))
    }

    var body: some View {
        VStack(spacing: 4) {
            Text(dayNumber)
                .font(.subheadline.weight(isToday ? .semibold : .regular))
                .foregroundStyle(isCurrentMonth ? .primary : .secondary)
                .frame(maxWidth: .infinity, alignment: .leading)

            if eventCount > 0 {
                HStack(spacing: 3) {
                    ForEach(0..<min(eventCount, 3), id: \.self) { _ in
                        Circle()
                            .fill(.tint)
                            .frame(width: 5, height: 5)
                    }
                    if eventCount > 3 {
                        Text("+\(eventCount - 3)")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                }
            } else {
                Spacer(minLength: 5)
            }
        }
        .padding(8)
        .frame(height: 48)
        .background(
            ZStack {
                if isSelected {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.accentColor.opacity(0.15))
                }
                if isToday {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.accentColor, lineWidth: 1)
                }
            }
        )
    }
}
