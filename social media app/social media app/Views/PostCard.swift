//
//  PostCard.swift
//  social media app
//
//  Created by Zachary Jensen on 11/12/25.
//

import SwiftUI

struct PostCard: View {
    let post: FunnyPost
    let isExpanded: Bool
    let onToggleExpanded: () -> Void
    let onReact: (Reaction) -> Void
    let onAddComment: (String) -> Void
    let onDeleteComment: (Comment) -> Void

    @State private var commentDraft: String = ""
    @State private var bounceKey: Int = 0
    @State private var isPressed: Bool = false
    @EnvironmentObject private var model: AppModel

    // Heuristic for long text expand
    private var shouldShowReadMore: Bool {
        !isExpanded && post.text.count > 220
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .firstTextBaseline) {
                Circle()
                    .fill(randomColor(for: post.author).opacity(0.25))
                    .frame(width: 34, height: 34)
                    .overlay(Text(String(post.author.prefix(1))).font(.headline))
                VStack(alignment: .leading, spacing: 2) {
                    Text(post.author)
                        .font(.headline).bold()
                    Text(post.timestamp, style: .time)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(post.text)
                    .font(.body)
                    .lineLimit(isExpanded ? nil : 5)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.secondarySystemBackground))
                    )

                if shouldShowReadMore {
                    Button {
                        onToggleExpanded()
                    } label: {
                        HStack(spacing: 6) {
                            Text("Read more")
                            Image(systemName: "chevron.down")
                                .font(.caption)
                        }
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(AppTheme.primaryRed)
                    }
                    .buttonStyle(.plain)
                }
            }

            // Compact reactions: emoji only with small count badge
            HStack(spacing: 10) {
                ForEach(Reaction.allCases, id: \.self) { reaction in
                    Button {
                        onReact(reaction)
                        bounceKey += 1
                    } label: {
                        ZStack(alignment: .topTrailing) {
                            Text(reaction.emoji)
                                .font(.body)

                            if post.reactions[reaction, default: 0] > 0 {
                                Text("\(post.reactions[reaction, default: 0])")
                                    .font(.caption2.weight(.semibold))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 2)
                                    .background(AppTheme.primaryRed, in: Capsule())
                                    .offset(x: 8, y: -8)
                            }
                        }
                        .padding(8)
                        .background(Color(.secondarySystemBackground), in: Capsule())
                        .overlay(
                            Capsule().stroke(FunTheme.accentGradient.opacity(0.7), lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)
                    .scaleEffect(bounceKey % 2 == 0 ? 1.0 : 1.05)
                    .animation(.spring(response: 0.25, dampingFraction: 0.6), value: bounceKey)
                }

                Spacer()

                Button(action: onToggleExpanded) {
                    Image(systemName: isExpanded ? "chevron.up" : "text.bubble")
                        .padding(8)
                        .background(Color(.secondarySystemBackground), in: Circle())
                        .overlay(Circle().stroke(FunTheme.accentGradient.opacity(0.7), lineWidth: 1))
                }
                .buttonStyle(.plain)
            }

            if isExpanded {
                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    if post.comments.isEmpty {
                        Text("Be the first to drop a code review quip. 💬🧑‍💻")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(post.comments) { comment in
                            HStack(alignment: .top, spacing: 8) {
                                Circle()
                                    .fill(randomColor(for: comment.author).opacity(0.25))
                                    .frame(width: 26, height: 26)
                                    .overlay(Text(String(comment.author.prefix(1))).font(.caption))
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text(comment.author).font(.subheadline).bold()
                                        Text(comment.timestamp, style: .time)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        Spacer()
                                        // Show delete for current user's own comments
                                        if comment.author == model.currentUser {
                                            Button(role: .destructive) {
                                                onDeleteComment(comment)
                                            } label: {
                                                Image(systemName: "trash")
                                                    .font(.caption)
                                            }
                                            .buttonStyle(.borderless)
                                            .accessibilityLabel("Delete comment")
                                        }
                                    }
                                    Text(comment.text)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }

                    HStack(spacing: 8) {
                        TextField("Add a constructive comment… ✍️", text: $commentDraft, axis: .vertical)
                            .lineLimit(1...4)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .stroke(FunTheme.accentGradient.opacity(0.6), lineWidth: 1)
                            )
                            .foregroundStyle(.primary)
                            .textInputAutocapitalization(.sentences)
                            .disableAutocorrection(false)

                        Button {
                            let trimmed = commentDraft.trimmingCharacters(in: .whitespacesAndNewlines)
                            guard !trimmed.isEmpty else { return }
                            onAddComment(trimmed)
                            commentDraft = ""
                        } label: {
                            Image(systemName: "paperplane.fill")
                                .foregroundStyle(.white)
                                .padding(8)
                                .background(FunTheme.accentGradient, in: Circle())
                        }
                        .buttonStyle(.plain)
                        .disabled(commentDraft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                    .padding(.top, 4)
                }
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(FunTheme.cardGradient)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(FunTheme.accentGradient.opacity(0.6), lineWidth: 1.2)
        )
        .shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: 8)
        .scaleEffect(isPressed ? 0.99 : 1.0)
        .animation(.spring(response: 0.25, dampingFraction: 0.8), value: isPressed)
        .onLongPressGesture(minimumDuration: 0.0, maximumDistance: 10, pressing: { pressing in
            withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                isPressed = pressing
            }
        }, perform: {})
    }

    private func randomColor(for seed: String) -> Color {
        let idx = abs(seed.hashValue) % max(1, FunTheme.funColors.count)
        return FunTheme.funColors[idx]
    }
}
