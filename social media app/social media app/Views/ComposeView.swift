//
//  ComposeView.swift
//  social media app
//
//  Created by Zachary Jensen on 11/12/25.
//

import SwiftUI

struct ComposeView: View {
    @EnvironmentObject var model: AppModel
    @State private var text: String = ""
    private let maxLength: Int = 280

    var remaining: Int {
        max(0, maxLength - text.count)
    }

    // Fun, engineering-focused samples
    let jokeBag: [String] = [
        "Standup: deleted code, gained speed, found inner peace. ✨",
        "PR: replaced polling with async/await; tests are happier than I am. 🧪",
        "Retro: action items assigned, memes archived, lessons learned (again). 🧯",
        "Added tracing. The system told me its secrets. 📈🕵️",
        "Flaky test stabilized by waiting for reality instead of time. ⏱️➡️✅",
        "Feature flag at 10%, confidence at 60%, dashboards at 100%. 📊",
        "Index added, CPU lowered, DBA smiled. 🗃️💡",
        "Docs updated before code merged. Who am I even? 📚",
        "Accessibility labels added; UX got nicer for everyone. ♿️💬",
        "Cache warmed, bugs chilled. Hit rate up, stress down. 🧊"
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("New Post")
                .font(.title2).bold()
                .foregroundStyle(AppTheme.primaryRed)

            TextEditor(text: $text)
                .frame(minHeight: 180)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .strokeBorder(remaining < 0 ? Color.red : Color.gray.opacity(0.25), lineWidth: 1)
                )

            HStack(spacing: 10) {
                Button {
                    if let sample = jokeBag.randomElement() {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        text = sample
                    }
                } label: {
                    Label("Insert Sample", systemImage: "text.badge.plus")
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(FunTheme.accentGradient, in: Capsule())
                        .foregroundStyle(.white)
                }

                Spacer()

                Group {
                    if remaining >= 20 {
                        Text("\(remaining)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    } else if remaining >= 0 {
                        Text("\(remaining)")
                            .font(.caption)
                            .foregroundStyle(.orange)
                    } else {
                        Text("\(remaining)")
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color(.secondarySystemBackground), in: Capsule())

                Button {
                    let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !trimmed.isEmpty, trimmed.count <= maxLength else { return }
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    model.addPost(text: trimmed)
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                        text = ""
                    }
                } label: {
                    Label("Post", systemImage: "paperplane.fill")
                        .padding(.horizontal, 18)
                        .padding(.vertical, 12)
                        .background(FunTheme.accentGradient, in: Capsule())
                        .foregroundStyle(.white)
                }
                .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || text.count > maxLength)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Compose")
    }
}
