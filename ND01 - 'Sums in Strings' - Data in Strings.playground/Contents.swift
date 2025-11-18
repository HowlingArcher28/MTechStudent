//  🏔️ MTECH Code Challenge ND01: "Sums in Strings"
//  Concept: Practice converting Strings to other types and evaluating data stored within them

//  Instructions:
    //  Create a function that takes a String as input and returns an Integer.
    //  Your task is to calculate the sum of the integers inside an input string.

//  Examples:
    //  Input: "The30quick20brown10f0x1203jumps914ov3r1349the102l4zy dog"
    //  Math: 30 + 20 + 10 + 0 + 1203 + 914 + 3 + 1349 + 102 + 4
    //  Output: 3635
    
//  ⌺ Black Diamond Challenge:
    //  Make another function. This one should also execute any mathematical operators contained in the string (+, -, /, * or x). If no operator separates two integers, add them by default. Thus, the string "13-3is10" would produce 20 (13 - 3 + 10).

import Foundation

func sumOfIntegers(in input: String) -> Int {
    //CharacterSet.decimalDigits is a predefined set of all Unicode decimal digit characters (0–9 and digits from other scripts).
    // .inverted returns the complement of that set: every character that is not a decimal digit.
    let nonDigits = CharacterSet.decimalDigits.inverted
    let parts = input.components(separatedBy: nonDigits)
    let ints = parts.compactMap { Int($0) }
    return ints.reduce(0, +)
}


print(sumOfIntegers(in: "The30quick20brown10f0x1203jumps914ov3r1349the102l4zy dog"))
