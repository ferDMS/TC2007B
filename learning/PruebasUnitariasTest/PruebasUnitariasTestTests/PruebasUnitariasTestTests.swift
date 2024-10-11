//
//  PruebasUnitariasTestTests.swift
//  PruebasUnitariasTestTests
//
//  Created by PEZ on 11/10/24.
//

import XCTest
@testable import PruebasUnitariasTest

// Very useful to test acceptance criteria
final class PruebasUnitariasTestTests: XCTestCase {

    // Testing function
    func testPositiveTip() throws {
        let calc = calcTotalWithTip(base: 100, tip: 10)
        let expected: Double = 110
        XCTAssertEqual(calc, expected, "Positive tip should be correct")
    }
    
    // Testing function
    func testNegativeTip() throws {
        let calc = calcTotalWithTip(base: 100, tip: -10)
        let expected: Double = 0
        XCTAssertEqual(calc, expected, "Negative tip should be 0")
    }
    
    // Testing views / testing through views
    func testCalcInView() throws {
        let view = ContentView(base: 100.0, tip: 10.0)
        let calc = view.calc()
        
        let expected: Double = 110
        
        XCTAssertEqual(calc, expected, "Negative tip should be 0")
    }


}
