//  🏔️ MTECH Code Challenge SF35: "Bubble Sort" 🫧
//  Concept: Learn about sorting algorithms and build one of the simpler, though less efficient ones; gain a brief introduction to sorting algorithms and time complexity

//  Instructions:
    //  Create a function that takes in an array of Ints.
    //  You are to sort this array without using the built in .sort() method.
    //  Implement a bubble sort. A visual example of what a bubble sort is is shown here: 🔗https://en.wikipedia.org/wiki/Bubble_sort#/media/File:Bubble-sort-example-300px.gif
    //  Return the sorted array

//  Examples:
    //  Input: [15, 5, 6, 7, 2, 3, 45, 12]
    //  Output: [2, 3, 5, 6, 7, 12, 15, 45]
func sortingNumbers(numberArray: [Int]) -> [Int]{
    var array = numberArray
    if array.count < 2 { return array }
    
    for firstNumber in 0..<(array.count - 1) {
        var swapped = false
        for checkedNumber in 0..<(array.count - 1 - firstNumber) {
            if array[checkedNumber] > array[checkedNumber + 1] {
                array.swapAt(checkedNumber, checkedNumber + 1)
                swapped = true
            }
        }
       if !swapped { break }
    }
    return array
}

let result = sortingNumbers(numberArray: [15, 5, 6, 7, 2, 3, 45, 12])
print("The sorted array is now \(result)")



//  ⌺ Black Diamond Challenge:
    //  Sorting algorthims are implemented by Swift under the hood so that you will not need to know them directly. Still, you may have occasion in your future as a coder in which you will need to know more.
    //  Browse through the Wikipedia page for sorting algorithms: 🔗https://en.wikipedia.org/wiki/Sorting_algorithm
    //  This is an article with complicated computer science theory; you do not need to understand the entire history of computing after reading one Wiki page. Take notes in a comment in this challenge on what you do glean and learn about the different sorting algorithms as you skim through.

import Foundation
