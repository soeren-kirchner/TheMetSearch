//
//  TheMetSearchUITests.swift
//  TheMetSearchUITests
//
//  Created by Sören Kirchner on 29.08.22.
//

import XCTest

class TheMetSearchUITests: XCTestCase {

    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
