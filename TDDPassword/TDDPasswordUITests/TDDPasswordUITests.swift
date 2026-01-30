//
//  TDDPasswordUITests.swift
//  TDDPasswordUITests
//
//  Created by Zachary Jensen on 1/27/26.
//

import XCTest
@testable import TDDPassword

final class TDDPasswordUITests: XCTestCase {

    

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
