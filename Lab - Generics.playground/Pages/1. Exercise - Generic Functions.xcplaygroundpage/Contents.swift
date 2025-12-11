/*:
## Exercise - Generic Functions
 
 The `duplicate` function below works only when working with Ints, but its body could work with any type. Rewrite the function to use a generic type `<T>` instead. Test your new function by calling it several times, using a String, an Int, and a Double.
 */


import Foundation

func duplicate<T>(_ value: T) -> (T, T) {
    return (value, value)
}
let duplicatedString = duplicate("hello")
let duplicatedInt = duplicate(42)
let duplicatedDouble = duplicate(3.14159)

//:  The function below retrieves a random value from an array of Ints and then deletes that value. The `inout` keyword means that it modifies the array passed into it directly. This function could work with an array of any type, so long as the type conforms to Equatable. Rewrite the function to use a generic type `<U>` instead, constraining to Equatable types. Test your new function by calling it several times, using an array of Strings, of Ints, and of Doubles.

func pullRandomElement<U: Equatable>(_ array: inout [U]) -> U? {
    guard let randomElement = array.randomElement(),
          let index = array.firstIndex(of: randomElement) else {
        return nil
    }
    array.remove(at: index)
    return randomElement
}

var stringArray = ["apple", "banana", "cherry", "date"]
var intArray = [1, 2, 3, 4, 5]
var doubleArray = [2.71, 3.14, 1.41, 1.73]

let pulledString1 = pullRandomElement(&stringArray)
let pulledString2 = pullRandomElement(&stringArray)

let pulledInt1 = pullRandomElement(&intArray)
let pulledInt2 = pullRandomElement(&intArray)

let pulledDouble1 = pullRandomElement(&doubleArray)
let pulledDouble2 = pullRandomElement(&doubleArray)

//:  The function below sorts an array, then returns a new array containing only the first and last Strings of the array after sorting. This function could work with an array of any type, so long as the type conforms to Comparable. Rewrite the function to use a generic type `<V>` instead, constraining to Comparable types. Test your new function by calling it several times, using an array of Strings, of Ints, and of Doubles.


func minMaxArray<V: Comparable>(_ array: [V]) -> [V] {
    var output: [V] = []
    
    if let minElement = array.min() {
        output.append(minElement)
    }
    
    if let maxElement = array.max() {
        output.append(maxElement)
    }
    
    return output
}

let minMaxStrings = minMaxArray(["zebra", "ant", "monkey", "bear"])
let minMaxInts = minMaxArray([10, -2, 99, 5, 0])
let minMaxDoubles = minMaxArray([3.14, 2.71, 1.41, 1.73])


/*:
page 1 of 4  |  [Next: Exercise - Generic Types](@next)
 */
