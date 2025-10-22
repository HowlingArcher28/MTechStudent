import Foundation

struct FamilyMember: Identifiable, Equatable, Hashable {
    let id: UUID
    var name: String
    var age: Int
    var relation: String
    var bio: String
    var imageName: String

    init(id: UUID = UUID(), name: String, age: Int, relation: String, bio: String, imageName: String) {
        self.id = id
        self.name = name
        self.age = age
        self.relation = relation
        self.bio = bio
        self.imageName = imageName
    }

    static let sample: [FamilyMember] = [
        FamilyMember(
            name: "Mandy Jensen",
            age: 48,
            relation: "Mom",
            bio: "Teacher, reader, and big time dog lover.",
            imageName: "Mandy"
        ),
        FamilyMember(
            name: "Gregg Jensen",
            age: 51,
            relation: "Dad",
            bio: "Coder and developer, lover of games, and a little too good at dad-jokes.",
            imageName: "Gregg"
        ),
        FamilyMember(
            name: "Katelyn Jensen",
            age: 13,
            relation: "Sister",
            bio: "Loves the flute, a little crazy, not the best at games.",
            imageName: "Katelyn"
        ),
        FamilyMember(
            name: "Rilee Jensen",
            age: 19,
            relation: "Brother",
            bio: "Drummer, pianist, loves all things music, currently out on his mission.",
            imageName: "Rilee"
        ),
        FamilyMember(
            name: "Evan Jensen",
            age: 15,
            relation: "Brother",
            bio: "Roblox fanatic, loves VR and all things food.",
            imageName: "Evan"
        ),
        FamilyMember(
            name: "Josh Jensen",
            age: 11,
            relation: "Brother",
            bio: "Loves all things LEGO, the color green, and will randomly share fun facts about everything.",
            imageName: "Josh"
        ),
        FamilyMember(
            name: "Theo",
            age: 7,
            relation: "Dog",
            bio: "A little annoying sometimes, but will absolutely demand pets.",
            imageName: "Theo"
        ),
        FamilyMember(
            name: "Lilly",
            age: 3,
            relation: "Dog",
            bio: "Sweet and loves playing fetch, not super into cuddling.",
            imageName: "Lilly"
        ),
        FamilyMember(
            name: "Rosie",
            age: 2,
            relation: "Dog",
            bio: "Snuggle expert — basically a big teddy bear.",
            imageName: "Rosie"
        )
    ]
}
