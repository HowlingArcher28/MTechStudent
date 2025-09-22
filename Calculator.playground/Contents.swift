import UIKit

//class Calculator {
//    private var currentValue: Double = 0
//    private var previousValue: Double?
//    private var pendingOperation: ((Double, Double) -> Double)?
//    private var isEnteringNumber = false
//    
//    // Input a digit or number (e.g., user presses "7")
//    func input(_ number: Double) {
//        if isEnteringNumber {
//            // Support entering multi-digit numbers if desired (simplified here)
//            currentValue = currentValue * 10 + number
//        } else {
//            currentValue = number
//            isEnteringNumber = true
//        }
//        print("Display: \(currentValue)")
//    }
//    
//    // "Press" plus button
//    func plus() {
//        commitPendingOperation()
//        pendingOperation = (+)
//        previousValue = currentValue
//        isEnteringNumber = false
//    }
//    
//    // "Press" minus button
//    func minus() {
//        commitPendingOperation()
//        pendingOperation = (-)
//        previousValue = currentValue
//        isEnteringNumber = false
//    }
//    
//    // "Press" multiply button
//    func multiply() {
//        commitPendingOperation()
//        pendingOperation = (*)
//        previousValue = currentValue
//        isEnteringNumber = false
//    }
//    
//    // "Press" divide button
//    func divide() {
//        commitPendingOperation()
//        pendingOperation = (/)
//        previousValue = currentValue
//        isEnteringNumber = false
//    }
//    
//    // "Press" equals button
//    func equals() {
//        commitPendingOperation()
//        pendingOperation = nil
//        previousValue = nil
//        isEnteringNumber = false
//    }
//    
//    // Invert sign (+/-)
//    func invertSign() {
//        currentValue = -currentValue
//        print("Display: \(currentValue)")
//    }
//    
//    // Percentage (%)
//    func percent() {
//        currentValue = currentValue / 100
//        print("Display: \(currentValue)")
//    }
//    
//    // Clear (C/AC)
//    func clear() {
//        currentValue = 0
//        previousValue = nil
//        pendingOperation = nil
//        isEnteringNumber = false
//        print("Display: \(currentValue)")
//    }
//    
//    // Helper to commit the current pending operation, if any
//    private func commitPendingOperation() {
//        if let operation = pendingOperation, let prev = previousValue {
//            currentValue = operation(prev, currentValue)
//            print("Display: \(currentValue)")
//        }
//    }
//}
//
//// Example usage:
//let calc = Calculator()
//
//// Simulate pressing: 7 + 2 =
//calc.input(7)
//calc.plus()
//calc.input(2)
//calc.equals()      // prints 9
//
//// Now multiply by 5
//calc.multiply()
//calc.input(5)
//calc.equals()      // prints
//
//// Invert sign, percent, clear
//calc.invertSign()  // prints -45
//calc.percent()     // prints -0.45
//calc.clear()       // prints 0
//
//calc.clear()
//calc.input(67)
//calc.multiply()
//calc.input(6.7)
//calc.equals()

class Calculator {
    enum Operation { case add, subtract, multiply, divide
        func apply(_ a: Double, _ b: Double) -> Double {
            switch self { case .add: return a + b
            case .subtract: return a - b
            case .multiply: return a * b
            case .divide: return a / b }
        }
    }
    private var currentValue = 0.0,
                previousValue: Double?, pendingOperation: Operation?, isEnteringNumber = false

    func input(_ n: Double) {
        currentValue = isEnteringNumber ? currentValue * 10 + n : n
        isEnteringNumber = true
        print("Display: \(currentValue)")
    }

    func operate(_ op: Operation) {
        commit()
        pendingOperation = op
        previousValue = currentValue
        isEnteringNumber = false
    }

    func equals() {
        commit();
        pendingOperation = nil;
        previousValue = nil;
        isEnteringNumber = false
    }
    func invertSign() {
        currentValue = -currentValue;
        print("Display: \(currentValue)")
    }
    
    func percent() {
        currentValue /= 100;
        print("Display: \(currentValue)")
    }
    func clear() {
        currentValue = 0;
        previousValue = nil;
        pendingOperation = nil;
        isEnteringNumber = false;
        print("Display: \(currentValue)")
    }

    private func commit() {
        if let pendingOperation, let previousValue {
            currentValue = pendingOperation.apply(previousValue, currentValue)
            print("Display: \(currentValue)")
        }
    }
}

// Example usage:
let calc = Calculator()

calc.input(8); calc.operate(.multiply); calc.input(5); calc.equals()
calc.clear(); calc.input(9); calc.operate(.multiply); calc.input(6); calc.equals()


