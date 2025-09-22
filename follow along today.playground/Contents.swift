import UIKit



// Asighning value as it goes through the loop. It is setting it to "index"
for index in 1...5 {
    print("This number is \(index)")
}
// _ gives it an empty value
for _ in 1...3 {
    print("Hello world!")
}

let names = ["Alice", "Bob", "Charlie", "Diana", "Eve"]
for name in names {
    print("Hello, \(name)")
}

for letter in "ABCDEFG" {
    print("Letter: \(letter)")
}

let vehicles = ["Unicycle" : 1, "Bycicle" : 2, "Trycicle" : 3, "Quad Bike" : 4]


// While loops

var numberOfLives = 3
/// A while loop will continue to run as long as the condition is true
while numberOfLives > 0 {
    //playMove()
    //updateLivesCount()
}

///controll transfer statements
///Break statements
/// the statement "break" breaks out of a loop early
for counter in -10...10 {
    print(counter)
    if counter == 0 {
        break
    }
}
/// Continue statements
for name in names {
    print("Hello, \(name)!")
    if name.contains("e") {
        continue
    }
    print("Congrats, \(name). You've got $100!")
    break
}








