//
//  FeedView.swift
//  social media app
//
//  Created by Zachary Jensen on 11/12/25.
//

import SwiftUI

struct FeedView: View {
    @EnvironmentObject var model: AppModel
    @State private var expandedPostIDs: Set<UUID> = []

    var body: some View {
        List {
            ForEach(model.posts) { post in
                PostCard(
                    post: post,
                    isExpanded: expandedPostIDs.contains(post.id),
                    onToggleExpanded: {
                        if expandedPostIDs.contains(post.id) {
                            expandedPostIDs.remove(post.id)
                        } else {
                            expandedPostIDs.insert(post.id)
                        }
                    },
                    onReact: { reaction in
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        model.react(reaction, to: post)
                    },
                    onAddComment: { text in
                        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                        model.addComment(text, to: post)
                        expandedPostIDs.insert(post.id)
                    },
                    onDeleteComment: { comment in
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        model.deleteComment(comment, from: post)
                    }
                )
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .listRowBackground(Color.clear)
            }
        }
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
        .navigationTitle("Feed")
    }
}
