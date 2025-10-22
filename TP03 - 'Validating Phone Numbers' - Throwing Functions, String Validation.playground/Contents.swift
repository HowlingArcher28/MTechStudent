//  🏔️ MTECH Code Challenge TP03: "Validating Phone Numbers"
//  Concept: Practice validating inputs to make sure they're what you're expecting; practice formatting text (you'll have to do this all the time!); practice using throwing functions to produce errors when something goes wrong

//  Instructions:
    // The API you're using needs a specific format for phone numbers: (xxx)-xxx-xxxx.
    // Write a throwing function that takes in a string and returns a formatted phone string, or throws if the string that was passed in is not a valid phone number.

//  Examples:
    //  Input: "5558675309"
    //  Output: "(555)-867-5309"

    //  Input: "phone number"
    //  Output: no output produced, error thrown and caught instead

//  ⌺ Black Diamond Challenge:
    //  Add a parameter to your function that allows you to select a country from an enum of supported phone number formats. Make it so your app successfully validates and formats phone numbers for three other countries.
    //  You can find phone number formats here: 🔗https://en.wikipedia.org/wiki/National_conventions_for_writing_telephone_numbers

import Foundation


func phoneNumberCheck(numbers: String) {
    let digits = numbers.filter { $0.isNumber }
    guard digits.count == 10 else {
        print("Not a phone number")
        return
    }
    let first = digits.prefix(3)
    let mid = digits.dropFirst(3).prefix(3)
    let last = digits.suffix(4)
    let formatted = "(\(first))-\(mid)-\(last)"
    print(formatted)
}
phoneNumberCheck(numbers: "Jeff")
phoneNumberCheck(numbers: "38566954")
phoneNumberCheck(numbers: "3856695432")


