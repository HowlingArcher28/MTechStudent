//  🏔️ MTECH Code Challenge SF31: "Times Tables"
//  Concept: Practice using for loops and string interpolation

//  Instructions:
    //  Create a function that prints a multiplication table for any integer.
    //  The table should show its multiples from 1-10.

//  Notes:
    //  You can use "\n" in a string to insert a line break, the equivalent of hitting "return."

//  Examples:
    //  Input: 5
    //  Output:
        //  1 * 5 = 5
        //  2 * 5 = 10
        //  3 * 5 = 15
        //  4 * 5 = 20
        //  5 * 5 = 25
        //  6 * 5 = 30
        //  7 * 5 = 35
        //  8 * 5 = 40
        //  9 * 5 = 45
        //  10 * 5 = 50



//func multiplicationTable(number: Int) {
//    var one = 1 * number
//    var two = 2 * number
//    var three = 3 * number
//    var four = 4 * number
//    var five = 5 * number
//    var six = 6 * number
//    var seven = 7 * number
//    var eight = 8 * number
//    var nine = 9 * number
//    var ten = 10 * number
//    print(one)
//    print(two)
//    print(three)
//    print(four)
//    print(five)
//    print(six)
//    print(seven)
//    print(eight)
//    print(nine)
//    print(ten)
//}
//
//multiplicationTable(number: 3)

func multiplicationTable(multiplyer: Int) {
    for number in 1...10 {
        print("\(number) * \(multiplyer) = \(number * multiplyer)")
    }
}

multiplicationTable(multiplyer: 3)
//  ⌺ Black Diamond Challenge:
    //  Make another function with the same goal, but which accepts an array of integers as a parameter and prints the tables for each integer in the array.

import Foundation
