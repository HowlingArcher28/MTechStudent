//  🏔️ MTECH Code Challenge ST12: "Sum by Sign"
//  Concept: Practice evaluating data in an array using for loops

//  Instructions:
    //  Create a function that takes an array of integers as input and returns an array of just two integers.
    //  The first returned element is the COUNT of all positives numbers in the input array; the second element is the SUM of negative numbers.
    //  0 is neither positive nor negative, so ignore it if it appears.

//  Notes:
    // If the input is an empty array or is nil, return nil.

//  Examples:
    //  Input: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, -11, -12, -13, -14, -15]
    //  Math: There are 10 positive integers; -11 + -12 + -13 + -14 + -15 = -65
    //  Output: [10, -65]

func intArray(myNumbers: [Int]?) -> [Int]? {
    guard let numbers = myNumbers, !numbers.isEmpty else {
        return nil
    }

    var positiveCount = 0
    var negativeSum = 0

    for n in numbers {
        if n > 0 {
            positiveCount += 1
        } else if n < 0 {
            negativeSum += n
        }
    }

    return [positiveCount, negativeSum]
}
intArray(myNumbers: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, -11, -12, -13, -14, -15])




//  ⌺ Black Diamond Challenge:
    //  Modify the function to accept an optional third parameter. This parameter should be a closure that takes an integer as input and returns a boolean value. This closure allows you to define custom logic for what constitutes a "positive" or "negative" number.

import Foundation
