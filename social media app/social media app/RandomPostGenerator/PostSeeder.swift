import Foundation

protocol PostGenerating {
    func generatePosts(count: Int) -> [FunnyPost]
}

struct PostSeeder: PostGenerating {
    var daysBack: Int = 7

    func generatePosts(count: Int) -> [FunnyPost] {
        var newPosts: [FunnyPost] = []
        let now = Date()
        let range: TimeInterval = TimeInterval(daysBack) * 24 * 60 * 60

        for _ in 0..<count {
            let author = SeedData.authors.randomElement() ?? "Engineer"

            let sentenceCount = Int.random(in: 3...6)
            var picked: [String] = []
            for _ in 0..<sentenceCount {
                if let s = SeedData.jokes.randomElement() {
                    picked.append(s)
                }
            }
            let text = picked.joined(separator: " ")

            let randomPast = now.addingTimeInterval(-Double.random(in: 0...range))

            var reactions: [Reaction: Int] = [:]
            reactions[.lol] = Int.random(in: 0...6)        // Upvote
            reactions[.heh] = Int.random(in: 0...5)        // Insightful
            reactions[.groan] = Int.random(in: 0...3)      // Needs Work
            reactions[.bug] = Int.random(in: 0...2)        // Bug
            reactions[.question] = Int.random(in: 0...2)   // Question

            let post = FunnyPost(
                author: author,
                text: text,
                timestamp: randomPast,
                reactions: reactions,
                comments: []
            )
            newPosts.append(post)
        }

        newPosts.sort { $0.timestamp > $1.timestamp }
        return newPosts
    }
}
