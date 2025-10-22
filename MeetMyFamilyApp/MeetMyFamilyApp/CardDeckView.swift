import SwiftUI

struct CardDeckView: View {
    @Binding var members: [FamilyMember]
    var onTap: ((FamilyMember) -> Void)?
    var onSwipe: ((FamilyMember, SwipeResult) -> Void)?

    init(members: Binding<[FamilyMember]>,
         onTap: ((FamilyMember) -> Void)? = nil,
         onSwipe: ((FamilyMember, SwipeResult) -> Void)? = nil) {
        self._members = members
        self.onTap = onTap
        self.onSwipe = onSwipe
    }

    var body: some View {
        ZStack {
            ForEach(Array(members.enumerated()), id: \.element.id) { index, member in
                SwipeCardView(member: member, onTap: {
                    // Only allow tapping the top card
                    if index == members.count - 1 {
                        onTap?(member)
                    }
                }) { result in
                    handleSwipe(member: member, result: result)
                }
                .stacked(at: index, in: members.count)
                .allowsHitTesting(index == members.count - 1)
            }
            if members.isEmpty {
                emptyState
            }
        }
        .animation(.spring, value: members)
    }

    private func handleSwipe(member: FamilyMember, result: SwipeResult) {
        if let idx = members.firstIndex(of: member) {
            members.remove(at: idx)
        }
        onSwipe?(member, result)
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "person.3.sequence.fill")
                .font(.system(size: 56))
                .foregroundStyle(.secondary)
            Text("You're all caught up")
                .font(.title2).bold()
            Text("No more family members in the deck.")
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private extension View {
    func stacked(at index: Int, in total: Int) -> some View {
        let offset = CGFloat(total - 1 - index) * 10
        return self
            .offset(y: offset)
            .scaleEffect(1 - CGFloat(total - 1 - index) * 0.03)
            .zIndex(Double(index))
    }
}
