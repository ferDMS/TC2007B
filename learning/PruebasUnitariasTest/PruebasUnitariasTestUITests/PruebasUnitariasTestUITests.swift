//
//  PruebasUnitariasTestUITests.swift
//  PruebasUnitariasTestUITests
//
//  Created by PEZ on 11/10/24.
//

import XCTest

// UI testing
final class PruebasUnitariasTestUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    // We grab something like the DOM of web development
    func testCalcTipButton() throws {
        
        // Test
        
    }

}
