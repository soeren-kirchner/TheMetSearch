//
//  TheMetSearchUITestsMinimumCharacterTest.swift
//  TheMetSearchUITests
//
//  Created by Sören Kirchner on 08.09.22.
//

import XCTest

class TheMetSearchUITestsMinimumCharacterTest: XCTestCase {

    // Disable "Connect Hardware Keyboard" in Simulator
    
    func getKey(char: String.Element) -> String {
        let char = String(char)
        let replacemets = [
            " ": "Leerzeichen"
        ]
        return replacemets[char] ?? char
    }

    func minimumCharacterHintTest() throws {

        let app = XCUIApplication()
        app.launch()
        
        let searchKeyword = "Van gogh"

        let searchfieldTextField = app.textFields["searchField"]
        XCTAssertTrue(searchfieldTextField.waitForExistence(timeout: 5))
        searchfieldTextField.tap()
        
        let minimumCharacterHint = app.staticTexts["MinimumCharachterHint"]
        
        XCTAssertTrue(minimumCharacterHint.exists)
        
        for (index, char) in searchKeyword.enumerated() {
            app.keys[getKey(char: char)].tap()
            if index < 3 {
                XCTAssertTrue(minimumCharacterHint.exists)
            }
            else {
                XCTAssertFalse(minimumCharacterHint.waitForExistence(timeout: index > 3 ? 0 : 2))
            }
        }
    }

}
