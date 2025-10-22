import SwiftUI

struct ContentView: View {
    @State private var liked: [FamilyMember] = []
    @State private var passed: [FamilyMember] = []
    @State private var deck: [FamilyMember] = FamilyMember.sample
    @State private var selectedMember: FamilyMember?

    private var topMember: FamilyMember? {
        deck.last
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color.blue.opacity(0.15), Color.purple.opacity(0.15)],
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    header
                    Spacer(minLength: 8)
                    CardDeckView(members: $deck, onTap: { member in
                        selectedMember = member
                    }) { member, result in
                        switch result {
                        case .right: liked.append(member)
                        case .left: passed.append(member)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    footerSummary
                        .padding(.top, 6)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 8)
                }
                .padding(.top, 12)
                .padding(.horizontal, 16)
                .safeAreaPadding(.bottom, 12)
                .frame(maxWidth: 520)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .sheet(item: $selectedMember) { member in
                FamilyMemberDetailView(member: member)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
        }
    }

    private var header: some View {
        HStack {
            Text("Meet My Family")
                .font(.title.bold())
            Spacer()
            Button {
                resetDeck()
            } label: {
                Label("Review All", systemImage: "arrow.clockwise")
                    .labelStyle(.iconOnly)
                    .font(.title3.weight(.semibold))
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Review All")
            .accessibilityHint("Refill the deck and clear selections to review everyone again.")
        }
        .padding(.horizontal, 4)
    }

    private func resetDeck() {
        deck = FamilyMember.sample
        liked.removeAll()
        passed.removeAll()
    }

    private var footerSummary: some View {
        HStack {
            Label("\(passed.count) A little anoying", systemImage: "clock")
                .foregroundStyle(.orange)
            Spacer()
            Label("\(liked.count) Amazing", systemImage: "heart.fill")
                .foregroundStyle(.green)
        }
        .font(.subheadline)
    }
}

#Preview {
    ContentView()
}
