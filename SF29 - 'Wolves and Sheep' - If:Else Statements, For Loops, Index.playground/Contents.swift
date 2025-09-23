//  🏔️ MTECH Code Challenge SF29: "Wolves and Sheep"
//  Concept: Think through the logic of how to identify the position of an item in an array relative to the size of the array. It is not uncommon to need to think about how elements in an array are ordered relative to each other, so this skill will be useful in future development.

//  Instructions:
    //  Wolves have been reintroduced to Great Britain. You are a sheep farmer, and are now plagued by wolves which pretend to be sheep. Fortunately, you are good at spotting them.

    //  Warn the sheep in front of the wolf that it is about to be eaten. Remember that you are standing at the front of the queue which is at the end of the array:

    //  [sheep, sheep, sheep, sheep, sheep, wolf, sheep, sheep] (YOU ARE HERE AT THE FRONT OF THE QUEUE)
    //    7      6      5      4      3            2      1
    //  If the wolf is the closest animal to you, return "Pls go away and stop eating my sheep". Otherwise, return "Oi! Sheep number N! You are about to be eaten by a wolf!" where N is the sheep's position in the queue.


func checkForWolf(Line: [String]) -> String {
    guard let wolfIndex = Line.firstIndex(of: "wolf") else {
        return "No wolf in the line!"
    }
    if wolfIndex == Line.count - 1 {
        return "Pls go away and stop eating my sheep"
    } else {
        let sheepNumber = Line.count - wolfIndex - 1
        return "Oi! Sheep number \(sheepNumber)! You are about to be eaten by a wolf!"
    }
}

let test1 = ["sheep", "sheep", "sheep", "wolf", "sheep"]
print(checkForWolf(Line: test1))
// Output: Oi! Sheep number 1! You are about to be eaten by a wolf!

let test2 = ["sheep", "sheep", "wolf"]
print(checkForWolf(Line: test2))
// Output: Pls go away and stop eating my sheep

let test3 = ["wolf", "sheep", "sheep", "sheep"]
print(checkForWolf(Line: test3))
// Output: Oi! Sheep number 3! You are about to be eaten by a wolf!

let test4 = ["sheep", "wolf"]
print(checkForWolf(Line: test4))
// Output: Pls go away and stop eating my sheep

let test5 = ["sheep", "sheep", "wolf", "sheep", "sheep"]
print(checkForWolf(Line: test5))
// Output: Oi! Sheep number 2! You are about to be eaten by a wolf!






//  Notes:
    //  There will always be exactly one wolf in the array.

//  Examples:
    //  Input: ["sheep", "sheep", "sheep", "wolf", "sheep"]
    //  Output: "Oi! Sheep number 1! You are about to be eaten by a wolf!"

    //  Input: ["sheep", "sheep", "wolf"]
    //  Output: "Pls go away and stop eating my sheep"

//  ⌺ Black Diamond Challenge:
    //  Create another function. This time, return the first and last n elements of the array. If the first and last n elements overlap (i.e., 3 first and 3 last in a 5 element array), return the whole array.

import Foundation
