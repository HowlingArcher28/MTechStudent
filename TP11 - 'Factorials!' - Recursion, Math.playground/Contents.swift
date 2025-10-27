//  🏔️ MTECH Code Challenge TP11: "Factorial"
//  Concept: Practice using recursive functions or while loops to perform a task repeatedly until complete; practice converting mathematical formulae to Swift code

//  Instructions:
    //  Factorial is a mathematical function where, for any integer 'n', you find the product of multiplying all integers less than (and including) n together. It is usually represented by an '!' in math.
        // 5! would include all integers less than 5, so 1, 2, 3, and 4. 5! is a shorthand way of writing 5 * 4 * 3 * 2 * 1.
    //  Create a function that accepts an Int parameter 'n' and returns 'n!' as described above.

//  Notes:
    //  Even though there are no positive integers less than 0, 0! = 1.
    //  You can assume the input will always be positive.

//  Examples:
    //  Input: factorial(0), Output: 1
    //  Input: factorial(1), Output: 1

    //  Input: factorial(3)
    //  Math: 1 * 2 * 3 = 6
    //  Output: 6

    //  Input: factorial(4)
    //  Math: 1 * 2 * 3 * 4 = 24
    //  Output: 24

func factorial(number: Int) -> Int {
    
    if number <= 1 { return 1 }
    
    var result = 1
    
    for add in 2...number {
        result *= add
    }
    return result
}

factorial(number: 20)
//  ⌺ Black Diamond Challenge:
    //  Learn about double factorials, then add another function that calculates those instead: 🔗https://en.wikipedia.org/wiki/Double_factorial
    //  Learn about primorials, then add another function that calculates those instead: 🔗https://en.wikipedia.org/wiki/Primorial

import Foundation
