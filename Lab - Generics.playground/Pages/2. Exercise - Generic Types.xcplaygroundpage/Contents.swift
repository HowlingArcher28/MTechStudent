/*:
## Exercise - Generic Types
 
 While most collections involve working with values at the beginning, end, or a specific index or the collection, this array only allows you to retrieve items from the center of the array. You know when you look at a stack of plates in the cupboard and the top one didn't get clean enough or it's a little bit dusty, but getting the bottom one would be too hrd to fish out, so you grab one from the middle of the stack? So this will be our "StackOfPlates" collection type.
 */

import Foundation

struct StackOfPlates<Element> {
    let id = UUID()
    private var array = [Element]()

    init(array: [Element] = []) {
        self.array = array
    }
    
    mutating func push(_ value: Element) {
        array.append(value)
    }

    mutating func pop() -> Element? {
        guard !array.isEmpty else { return nil }
        let middleIndex = (array.count - 1) / 2
        return array.remove(at: middleIndex)
    }
}

//:  Convert the StackOfPlates struct to be a generic type so that it can hold any type, not just String. Test it below by creating several StackOfPlates instances using different types.

var stringPlates = StackOfPlates(array: ["top", "clean", "dusty", "bottom"])
let poppedString1 = stringPlates.pop()
stringPlates.push("new")
let poppedString2 = stringPlates.pop()

var intPlates = StackOfPlates(array: [10, 20, 30, 40, 50])
let poppedInt1 = intPlates.pop()
intPlates.push(60)
let poppedInt2 = intPlates.pop()

var doublePlates = StackOfPlates(array: [1.1, 2.2, 3.3])
let poppedDouble1 = doublePlates.pop()
doublePlates.push(4.4)
let poppedDouble2 = doublePlates.pop()

//: Use an extension of StackOfPlates to conform it to Identifiable so that one stack of plates has a separate ID than another.

extension StackOfPlates: Identifiable {}
/*:
[Previous](@previous)  |  page 2 of 4  |  [Next: Exercise - Associated Types](@next)
 */
