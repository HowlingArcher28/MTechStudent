//  🏔️ MTECH Code Challenge ND10: "Human, Cat, Dog Years"
//  Concept: Practice doing math with conditional paths based on input data

//  Instructions:
    //  I have a cat and a dog.
    //  I got them at the same time as a kitten/puppy. That was humanYears years ago.
    //  Create a function take that takes an Int called humanYears as input, and returns a tuple with humanYears, catYears, and dogYears.

//  Notes:
    //  humanYears >= 1
    //  humanYears are whole numbers only

    //  Cat Years
    //  15 cat years for first human year
    //  +9 cat years for second human year
    //  +4 cat years for each year after that

    //  Dog Years
    //  15 dog years for first human year
    //  +9 dog years for second human year
    //  +5 dog years for each year after that

//  Examples:
    //  Input: animalYearCalculator(humanYears: 9)
    //  Math: Based on the formulae above, catYears will be 15 + 9 + (4 * 7), dogYears will be 15 + 9 + (5 * 7)
    //  Output: (humanYears: 9, catYears: 52, dogYears: 59)

//  ⌺ Black Diamond Challenge:
    //  Create more calculators for different animals. You could differentiate between large and small dogs, calculate parakeet or Galapagos tortoise years, or any other species you choose. Calculate them how you see fit.

import Foundation

func animalYearCalculator(humanYears: Int) -> (humanYears: Int, catYears: Int, dogYears: Int) {
    var catYears = 0
    var dogYears = 0
    
    if humanYears >= 1 {
        catYears += 15
        dogYears += 15
    }
    if humanYears >= 2 {
        catYears += 9
        dogYears += 9
    }
    if humanYears >= 3 {
        catYears += (humanYears - 2) * 4
        dogYears += (humanYears - 2) * 5
    }
    
    return (humanYears, catYears, dogYears)
}


let result = animalYearCalculator(humanYears: 9)

