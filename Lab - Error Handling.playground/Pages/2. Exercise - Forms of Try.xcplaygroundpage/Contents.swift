/*:
## Exercise - Forms of Try
 
 The throwing function below produces an error if the user attempts to divide by zero. Call the function using `try` in a `do`/`catch` statement, printing the error to the console. Test using valid and invalid inputs to see the result.
 */

 enum MathError: Error {
 case divideByZero
}

func divide(_ numerator: Double, by denominator: Double) throws -> Double {
 guard denominator != 0 else { throw MathError.divideByZero }
 return numerator / denominator
}
 
do {
    let valid = try divide(10, by: 2)
    print("10 / 2 = \(valid)")
    
    
    let _ = try divide(5, by: 0)
    print("This line won't execute due to the throw above.")
} catch {
    print("Division error caught: \(error)")
}
//:  Now call the function using `try?`. Since errors are not handled when using `try?`, you do not need a `do`/`catch` statement. Test using valid and invalid inputs, printing the result.

let optionalValid = try? divide(9, by: 3)
print("Optional valid result: \(String(describing: optionalValid))")

let optionalInvalid = try? divide(1, by: 0)
print("Optional invalid result: \(String(describing: optionalInvalid))")


let safeValue = (try? divide(7, by: 0)) ?? .infinity
print("Safe value with default: \(safeValue)")

//:  Finally, call the function using `try!` and test it with an invalid input. What happens if the input is invalid? Write a comment explaining your answer, then set a valid input.

// Using `try!`: makes sure no error will be thrown.
// If the input is invalid like denominator == 0, the program will crash.

let forced = try! divide(8, by: 4)
print("Forced (try!) result: \(forced)")


/*:
[Previous](@previous)  |  page 2 of 4  |  [Next: Exercise - Associated Values](@next)
 */
