//  🏔️ MTECH Code Challenge TP10: "Palindromes"
//  Concept: Practice finding mathematical/code/logical solutions to language related tasks. You'll need to think about what makes a palindrome a palindrome and how that can translate to code.

//  Instructions:
    //  You may remember that a palindrome is a word that's spelled the same backward and forwards — like "mom" or "racecar."
    //  Create a function that accepts a string as input and returns TRUE if the string is a palindrome.

//  Examples:
    //  Input: "rotator"
    //  Output: true

    //  Input: "mississippi"
    //  Output: false

//  ⌺ Black Diamond Challenge:
    //  Find a way to check whether a phrase or sentence is a palindrome — for example, "Taco Cat" or, "Too bad I hid a boot." You'll have to find a way to remove spaces in your phrases to get the function to work.


//func palindromeChecker(imput: String) {
//    var text = imput.filter{ $0.isLetter }
//    var firstLetter = text.prefix(1)
//    var lastLetter = text.suffix(1)
//    
//    for letters in text {
//        while text.count > 1 {
//            
//        }
//    }
//    
//    
//    
//}
func palindromeChecker(imput: String) -> Bool {
    let letters = imput.lowercased().filter { $0.isLetter }
    var chars = Array(letters)

    while chars.count > 1 {
        if chars.first != chars.last {
            return false
        }
        chars.removeFirst()
        chars.removeLast()
    }
    return true
}
palindromeChecker(imput: "Taco cat")
palindromeChecker(imput: "Jeff")
//  Fun Facts:
    //  The Finnish word "saippuakauppias" is 15 letters, is a palindrome, and is used regularly.
    //  "A man, a plan, a canal - panama!" is a famous palindrome by Leigh Mercer; Dan Hoey expanded it to 540 words: 🔗http://complex.gmu.edu/people/ernie/witty/Hoey_palindrome.html

import Foundation
