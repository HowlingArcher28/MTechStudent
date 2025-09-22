import UIKit
    // this is the main function
func generateMadLib(place1: String, adjective1: String, name: String, noun: String, adjective2: String, creature: String, verbEndingWithIng1: String, place2: String, verbEndingWithIng2: String, object: String, adjective3: String ) -> String {
    
    
    // checking to see if anything is not valid
    var strings = [place1, adjective1, name, noun, adjective2, creature, verbEndingWithIng1, place2, verbEndingWithIng2, object, adjective3]
    strings.shuffle()
    guard isValid(with: strings) else {
        
        return "Invalid Imput"
    }
    // the words get randomized here
var places = [place1, place2]
places.shuffle()

var adjectives = [adjective1, adjective2, adjective3]
adjectives.shuffle()

var verbEndingWithIngs = [verbEndingWithIng1, verbEndingWithIng2]
verbEndingWithIngs.shuffle()
    
        // This is what its printing
    let story1 = "Yesterday, I went to \(places[0]) with my \(adjectives[0]) friend \(name). We were looking for a \(noun), but instead we found a \(adjectives[1]) \(creature) \(verbEndingWithIngs[0]) in the middle of \(places[1])! Everyone started \(verbEndingWithIngs[1]), and someone even dropped their \(object). It was the most \(adjectives[2]) day I've had all year."
    
    let story2 = "Last weekend, I had the weirdest dream. I was at \(places[0]) with my \(adjectives[0]) friend \(name), and we were riding a giant \(noun) through a crowd. Suddenly, a \(adjectives[1]) \(creature) appeared out of nowhere, \(verbEndingWithIngs[0]) like it owned the place. The entire \(places[1]) started shaking as people began \(verbEndingWithIngs[1]) in panic. One guy even threw his \(object) at the creature. Honestly, it was a \(adjectives[2]) mess—but kind of epic."
    
    let story3 = "This morning, I decided to take a walk to \(places[0]) with my \(adjectives[0]) friend \(name). We brought along a \(noun), just in case we needed it. Out of nowhere, a \(adjectives[1]) \(creature) burst out from behind a bench, \(verbEndingWithIngs[0]) like it hadn’t slept in weeks. We ran all the way to \(places[1]) while \(verbEndingWithIngs[1]) as fast as we could. I nearly lost my \(object), but luckily \(name) caught it. What a \(adjectives[2]) way to start the day!"
        // put stories in here to shuffle them
    var story = [story1, story2, story3]
    story.shuffle()
        print(story[0])
        return "end"
    
}
  // this checks to see if any of the strings are empty
func isValid(with strings: [String]) -> Bool {
    for string in strings {
        
        if string.isEmpty {
            return false
        }
    }
    return true
}

// Generate stuff here
generateMadLib(place1: "Kentucky", adjective1: "funny", name: "George", noun: "pinapple", adjective2: "fluffy", creature: "frog", verbEndingWithIng1: "sprinting", place2: "beach", verbEndingWithIng2: "jumping", object: "cup", adjective3: "colorfull")
