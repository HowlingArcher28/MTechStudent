import SwiftUI

struct SwipeCardView: View {
    let member: FamilyMember
    var onTap: () -> Void = {}
    var onSwipe: (SwipeResult) -> Void

    @State private var offset: CGSize = .zero
    @State private var isGone: Bool = false

    private let threshold: CGFloat = 120

    var body: some View {
        ZStack(alignment: .topLeading) {
            cardContent
                .overlay(likeOverlay.opacity(likeOpacity))
                .overlay(nopeOverlay.opacity(nopeOpacity))
        }
        .padding(.horizontal, 12) // slightly tighter
        .frame(maxWidth: 460) // cap card width so it doesn’t feel oversized
        .offset(x: offset.width, y: offset.height)
        .rotationEffect(.degrees(Double(offset.width / 12)))
        .scaleEffect(isGone ? 0.9 : 1)
        .animation(.interactiveSpring(), value: offset)
        .animation(.easeInOut, value: isGone)
        .contentShape(Rectangle())
        .onTapGesture {
            // Only trigger if not actively swiping away
            if !isGone {
                onTap()
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    offset = value.translation
                }
                .onEnded { value in
                    handleDragEnd(translation: value.translation)
                }
        )
        .accessibilityElement(children: .contain)
        .accessibilityLabel("\(member.name), \(member.age). \(member.relation). \(member.bio)")
        .accessibilityHint("Swipe right to like, left to pass. Double tap to see more details.")
    }

    private var likeOpacity: Double {
        let progress = min(max(offset.width / threshold, 0), 1)
        return Double(progress)
    }

    private var nopeOpacity: Double {
        let progress = min(max(-offset.width / threshold, 0), 1)
        return Double(progress)
    }

    private var likeOverlay: some View {
        Text("Amazing")
            .font(.system(size: 28, weight: .heavy)) // smaller
            .padding(10)
            .foregroundStyle(.green)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.green, lineWidth: 3)
            )
            .rotationEffect(.degrees(-12))
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .topLeading)
    }

    private var nopeOverlay: some View {
        Text("A little anoying")
            .font(.system(size: 24, weight: .heavy)) // smaller
            .padding(10)
            .foregroundStyle(.red)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.red, lineWidth: 3)
            )
            .rotationEffect(.degrees(12))
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .topTrailing)
    }

    private var cardContent: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(LinearGradient(colors: [.gray.opacity(0.2), .gray.opacity(0.05)], startPoint: .top, endPoint: .bottom))
                memberImage
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                    .overlay(Color.primary.opacity(0.08))
            }
            .frame(height: 300) // reduced from 360
            .clipShape(RoundedRectangle(cornerRadius: 18))
            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: 6) {
                    Text(displayName(for: member))
                        .font(.title2).bold() // smaller
                    Text("\(member.age)")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                Text(member.relation)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(member.bio)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                    .lineLimit(3)
            }
            .padding(.horizontal, 6)
            .padding(.bottom, 10)
        }
        .padding(10)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .shadow(radius: 8, y: 5)
    }

    private var memberImage: Image {
        if assetImageExists(named: member.imageName) {
            return Image(member.imageName)
        } else {
            return Image(systemName: member.imageName)
        }
    }

    private func assetImageExists(named name: String) -> Bool {
        #if os(macOS)
        return NSImage(named: NSImage.Name(name)) != nil
        #else
        return UIImage(named: name) != nil
        #endif
    }

    private func handleDragEnd(translation: CGSize) {
        if translation.width > threshold {
            swipe(.right)
        } else if translation.width < -threshold {
            swipe(.left)
        } else {
            withAnimation(.spring) {
                offset = .zero
            }
        }
    }

    private func swipe(_ result: SwipeResult) {
        let horizontal: CGFloat = result == .right ? 1000 : -1000
        withAnimation(.spring) {
            offset = CGSize(width: horizontal, height: 0)
            isGone = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            onSwipe(result)
        }
    }

    private func displayName(for member: FamilyMember) -> String {
        let first = member.name.split(separator: " ").first.map(String.init) ?? member.name
        let targets: Set<String> = ["rosie", "josh", "evan", "theo", "katelyn", "rilee"]
        return targets.contains(first.lowercased()) ? first : member.name
    }
}

enum SwipeResult {
    case left
    case right
}
