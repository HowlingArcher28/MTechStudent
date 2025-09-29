//  🏔️ MTECH Code Challenge SF34: "Target Practice"
//  Concept: Practice looping through an array to find multiple values and evaluate their relationship; optionally, discuss with instructor time complexity

//  Instructions:
    //  Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
    //  You can return the answer in any order.

//  Examples:
    //  Input: nums = [2,7,11,15], target = 9
    //  Output: [0,1]
    //  Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].

    //  Input: nums = [3,2,4], target = 6
    //  Output: [1,2]

    //  Input: nums = [3,3], target = 6
    //  Output: [0,1]
    
//func target(numbers: [Int]) -> [Int] {
//    numbers.filter{$0 < 9}
//        
//   
//    
//    
//}

func target(numbers: [Int], target: Int) -> [Int] {
    for i in 0..<numbers.count {
        for j in (i + 1)..<numbers.count {
            if numbers[i] + numbers[j] == target {
                return [i, j]
            }
        }
    }
    return []
}

func explainTarget(numbers: [Int], targetSum: Int) -> String {
    let fix = target(numbers: numbers, target: targetSum)
    if fix.count == 2 {
        let i = fix[0], j = fix[1]
        let a = numbers[i], b = numbers[j]
        return "Found a match: \(a) + \(b) = \(targetSum)"
    } else {
        return "No two numbers in \(numbers) add up to \(targetSum)."
    }
}


explainTarget(numbers: [3,15,5,6,2], targetSum: 8) // Expected: [0, 2] because 3 + 5 = 8

// Try it:

//  ⌺ Black Diamond Challenge:
    //  Consider if this function was given a very large array to work with, of say 10,000 integers, with a very high target value.
    //  If your solution involved looping through the array for each number, the time that it would take to complete the function would increase exponentially. In a comment, explain why this is.
    //  There is another solution to this problem that does not take as long, though it may be difficult at this stage in your progress to know how to code it. In a comment, brainstorm how that secondary solution might work.

import Foundation
