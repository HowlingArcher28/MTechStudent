import SwiftUI

struct FamilyMemberDetailView: View {
    let member: FamilyMember

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.blue.opacity(0.15),
                                    Color.purple.opacity(0.12)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    memberImage
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                        .overlay(Color.primary.opacity(0.06))
                        .padding(0)
                        .foregroundStyle(.primary.opacity(0.75))
                }
                .frame(height: 260)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.primary.opacity(0.08), lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .accessibilityHidden(true)
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(member.name)
                            .font(.largeTitle.weight(.bold))
                        Spacer()
                        Text("\(member.age)")
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(.secondary)
                            .accessibilityLabel("Age \(member.age)")
                    }
                    Text(member.relation)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                GroupBox {
                    VStack(alignment: .leading, spacing: 12) {
                        Label("About \(member.name)", systemImage: "info.circle")
                            .font(.headline)
                        Text(member.bio)
                            .font(.body)
                            .foregroundStyle(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                        VStack(alignment: .leading, spacing: 8) {
                            aboutLine(icon: "person.text.rectangle",
                                      text: "\(member.name) is \(myRelationPhrase(for: member.relation)).")
                            aboutLine(icon: "calendar",
                                      text: "Age: \(member.age)")
                            aboutLine(icon: "quote.bubble",
                                      text: "One word: \(member.bioSummaryWord).")
                            aboutLine(icon: "gamecontroller",
                                      text: aboutFunStyle(for: member))
                        }
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                        .accessibilityElement(children: .combine)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .groupBoxStyle(.automatic)
                GroupBox {
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Personal notes", systemImage: "person.crop.circle.badge.checkmark")
                            .font(.headline)
                        ForEach(personalizedNotes(for: member), id: \.self) { line in
                            aboutLine(icon: "arrow.right", text: line)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                Spacer(minLength: 12)
            }
            .padding()
        }
        .navigationTitle(member.name)
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

    private func aboutLine(icon: String, text: String) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Image(systemName: icon)
                .foregroundStyle(.secondary)
            Text(text)
        }
    }

    private func myRelationPhrase(for relation: String) -> String {
        let lower = relation.lowercased()
        switch lower {
        case "mom", "mother": return "my mom"
        case "dad", "father": return "my dad"
        case "sister": return "my sister"
        case "brother": return "my brother"
        default:
            return "my \(relation.lowercased())"
        }
    }

    private func aboutFunStyle(for member: FamilyMember) -> String {
        let bio = member.bio.lowercased()
        if bio.contains("music") { return "Loves music and is always working on something new." }
        if bio.contains("lego") { return "Enjoys building and getting creative." }
        if bio.contains("dog") { return "Big fan of dogs and outdoor time." }
        if bio.contains("vr") || bio.contains("game") { return "Likes games and trying new tech." }
        if bio.contains("coder") || bio.contains("developer") { return "Enjoys coding and problem solving." }
        if bio.contains("reader") { return "Always has a good book nearby." }
        return "Easy to spend time with and fun to be around."
    }

    private func personalizedNotes(for member: FamilyMember) -> [String] {
        let lowerName = member.name.lowercased()
        if lowerName.contains("mandy") {
            return [
                "Balances a lot and still finds time to read.",
                "Great with dogs and always kind."
            ]
        } else if lowerName.contains("gregg") {
            return [
                "Knows coding and enjoys games.",
                "Good at explaining tech things."
            ]
        } else if lowerName.contains("katelyn") {
            return [
                "Plays the flute and brings good energy to concerts.",
                "Fun to be around."
            ]
        } else if lowerName.contains("rilee") {
            return [
                "Into music — drums and piano.",
                "On a mission right now."
            ]
        } else if lowerName.contains("evan") {
            return [
                "Likes VR and trying different foods.",
                "Easygoing and fun."
            ]
        } else if lowerName.contains("josh") {
            return [
                "Really into LEGO and building things.",
                "Shares interesting facts."
            ]
        }
        let bio = member.bio.lowercased()
        var notes: [String] = []
        if bio.contains("music") { notes.append("Music is a big part of their life.") }
        if bio.contains("lego") { notes.append("Enjoys building and being creative.") }
        if bio.contains("dog") { notes.append("Gets along great with dogs.") }
        if bio.contains("game") || bio.contains("vr") { notes.append("Likes games and new tech.") }
        if bio.contains("coder") || bio.contains("developer") { notes.append("Enjoys coding and solving problems.") }
        if bio.contains("reader") { notes.append("Likes reading and sharing recommendations.") }
        if notes.isEmpty {
            notes = ["Easy to hang out with and brings a positive vibe."]
        }
        return notes
    }
}

private extension FamilyMember {
    var bioSummaryWord: String {
        let lower = bio.lowercased()
        if lower.contains("music") { return "musical" }
        if lower.contains("lego") { return "creative" }
        if lower.contains("dog") { return "animal-loving" }
        if lower.contains("game") { return "playful" }
        if lower.contains("reader") { return "thoughtful" }
        if lower.contains("vr") { return "techy" }
        if lower.contains("coder") || lower.contains("developer") { return "tech-savvy" }
        return "awesome"
    }

    var firstName: String {
        name.split(separator: " ").first.map(String.init) ?? name
    }
}
