import SwiftUI

struct CardPreviewView: View {
    let card: Card

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(card.backgroundColor.gradient)
                        .frame(height: 260)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .strokeBorder(.white.opacity(0.2), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)

                    VStack(spacing: 12) {
                        if let imageData = card.imageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 160)
                                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                .padding(.horizontal)
                        } else {
                            Image(systemName: "party.popper.fill")
                                .font(.system(size: 60))
                                .foregroundStyle(.white.opacity(0.9))
                        }

                        Text("You're invited!")
                            .font(.title.bold())
                            .foregroundStyle(.white)
                    }
                    .padding()
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text(card.description.isEmpty ? "No description yet." : card.description)
                        .font(.body)
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    HStack(spacing: 8) {
                        Image(systemName: "calendar")
                        Text(card.date.formatted(date: .abbreviated, time: .shortened))
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(.background)
                        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
                )
                .padding(.horizontal)

                Spacer(minLength: 20)
            }
            .padding(.top)
        }
        .navigationTitle("Card Preview")
    }
}

#Preview {
    CardPreviewView(card: Card(description: "Zach's 30th Birthday Bash! Come for games, pizza, and cake.", date: .now.addingTimeInterval(60*60*24*7), backgroundColor: .purple, imageData: nil))
}
