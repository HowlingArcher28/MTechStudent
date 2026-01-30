//
//  TDDPasswordTests.swift
//  TDDPasswordTests
//
//  Created by Zachary Jensen on 1/27/26.
//

import XCTest
@testable import TDDPassword

final class TDDPasswordTests: XCTestCase {

    enum PasswordValidationState: Equatable {
        case success
        case failure(String)
    }

    struct PasswordValidator {
        func validate(_ password: String, completion: @escaping (PasswordValidationState) -> Void) {
           
           
                if password.isEmpty {
                    completion(.failure("Please enter a password."))
                } else {
                    completion(.success)
            }
        }
    }

    // MARK: - Tests

    func test_passwordIsEmpty_showsFailureMessage_usesExpectation() {
        // Arrange
        let validator = PasswordValidator()
        let emptyPassword = ""
        let expectation = expectation(description: "Validates password")

        // Act
        validator.validate(emptyPassword) { state in
            // Assert
            switch state {
            case .failure(let message):
                XCTAssertEqual(message, "Please enter a password.")
            default:
                XCTFail("Expected failure for empty password, got: \(state)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)
    }
}
