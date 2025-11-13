//
//  ProfileView.swift
//  social media app
//
//  Created by Zachary Jensen on 11/12/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var model: AppModel
    @State private var showingEdit = false

    var myPosts: [FunnyPost] {
        model.posts.filter { $0.author == model.profile.username }
    }

    var totalReactions: Int {
        myPosts.reduce(0) { sum, post in
            sum + post.reactions.values.reduce(0, +)
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack(spacing: 12) {
                    avatarView()
                        .frame(width: 70, height: 70)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(fullNameOrUsername)
                            .font(.title2).bold()
                        Text("@\(model.profile.username)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        if !model.profile.bio.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            Text(model.profile.bio)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    Spacer()
                }
                .padding(14)
                .background(FunTheme.cardGradient, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(FunTheme.accentGradient.opacity(0.9), lineWidth: 1)
                )

                HStack {
                    StatTile(title: "Posts", value: "\(myPosts.count)", emoji: "📝")
                    StatTile(title: "Reactions", value: "\(totalReactions)", emoji: "🎉")
                    StatTile(title: "Comments", value: "\(myPosts.flatMap(\.comments).count)", emoji: "💬")
                }

                Divider().padding(.vertical, 4)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Your Posts")
                        .font(.headline)
                        .foregroundStyle(FunTheme.accentGradient)
                    ForEach(myPosts) { post in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(post.text)
                            HStack(spacing: 10) {
                                ForEach(Reaction.allCases, id: \.self) { r in
                                    if post.reactions[r, default: 0] > 0 {
                                        Text("\(r.emoji) \(post.reactions[r, default: 0])")
                                            .font(.caption.weight(.semibold))
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 6)
                                            .background(.ultraThinMaterial, in: Capsule())
                                            .overlay(
                                                Capsule().stroke(FunTheme.accentGradient.opacity(0.6), lineWidth: 1)
                                            )
                                    }
                                }
                                Spacer()
                                Text(post.timestamp, style: .date)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(12)
                        .background(FunTheme.cardGradient, in: RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(FunTheme.accentGradient.opacity(0.6), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingEdit = true
                } label: {
                    Label("Edit Profile", systemImage: "pencil")
                }
            }
        }
        .sheet(isPresented: $showingEdit) {
            ProfileEditView()
                .environmentObject(model)
        }
    }

    private var fullNameOrUsername: String {
        let fn = model.profile.firstName.trimmingCharacters(in: .whitespaces)
        let ln = model.profile.lastName.trimmingCharacters(in: .whitespaces)
        let full = [fn, ln].filter { !$0.isEmpty }.joined(separator: " ")
        return full.isEmpty ? model.profile.username : full
    }

    @ViewBuilder
    private func avatarView() -> some View {
        if let name = model.profile.profileImageName,
           let ui = UIImage(named: name) {
            Image(uiImage: ui)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .overlay(Circle().stroke(FunTheme.accentGradient.opacity(0.9), lineWidth: 2))
                .background(
                    Circle().fill(Color(.secondarySystemBackground))
                )
                .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
        } else if let ui = UIImage(named: "ProfileAvatar") {
            Image(uiImage: ui)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .overlay(Circle().stroke(FunTheme.accentGradient.opacity(0.9), lineWidth: 2))
                .background(
                    Circle().fill(Color(.secondarySystemBackground))
                )
                .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
        } else {
            ZStack {
                Circle()
                    .fill(Color(.secondarySystemBackground))
                Circle()
                    .stroke(FunTheme.accentGradient.opacity(0.9), lineWidth: 2)
                    .blur(radius: 1.0)
                    .opacity(0.7)
                Text(String(model.profile.username.prefix(1)))
                    .font(.title2).bold()
            }
        }
    }
}
