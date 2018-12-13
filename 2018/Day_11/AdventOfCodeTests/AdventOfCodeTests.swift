//
//  AdventOfCodeTests.swift
//  AdventOfCodeTests
//
//  Created by Jasdeep Saini on 12/9/18.
//  Copyright © 2018 Outsite Networks. All rights reserved.
//

import XCTest

class AdventOfCodeTests: XCTestCase {
    func testCalculatePowerLevelForExample1() {
        XCTAssertEqual(calculatePowerLevel(for: Coordinate(x: 3, y: 5), serialNumber: 8), 4)
    }

    func testCalculatePowerLevelForExample2() {
        XCTAssertEqual(calculatePowerLevel(for: Coordinate(x: 122, y: 79), serialNumber: 57), -5)
    }

    func testCalculatePowerLevelForExample3() {
        XCTAssertEqual(calculatePowerLevel(for: Coordinate(x: 217, y: 196), serialNumber: 39), 0)
    }

    func testCalculatePowerLevelForExample4() {
        XCTAssertEqual(calculatePowerLevel(for: Coordinate(x: 101, y: 153), serialNumber: 71), 4)
    }

    func testFindSquareWithLargestTotalPowerForExample1() {
        let result = findSquareWithLargestTotalPower(with: 18, gridSizeRange: 3...3)
        XCTAssert(result.coordinate.x == 33 && result.coordinate.y == 45)
    }

    func testFindSquareWithLargestTotalPowerForExample2() {
        let result = findSquareWithLargestTotalPower(with: 42, gridSizeRange: 3...3)
        XCTAssert(result.coordinate.x == 21 && result.coordinate.y == 61)
    }

    func testFindSquareWithLargestTotalPowerForInput() {
        let result = findSquareWithLargestTotalPower(with: 9221, gridSizeRange: 3...3)
        XCTAssert(result.coordinate.x == 20 && result.coordinate.y == 77)
    }

    func testFindSquareWithLargestTotalPowerForInput_part2() {
        let result = findSquareWithLargestTotalPower(with: 9221, gridSizeRange: 1...300)
        print("\(result.coordinate.x) \(result.coordinate.y) \(result.gridSize)")
        XCTAssert(result.coordinate.x == 143 && result.coordinate.y == 57 && result.gridSize == 10)
    }

    func testFindSquareWithLargestTotalPowerForInput_part2_Example1() {
        let result = findSquareWithLargestTotalPower(with: 18, gridSizeRange: 1...300)
        XCTAssert(result.coordinate.x == 90 && result.coordinate.y == 269 && result.gridSize == 16)
    }

    func testFindSquareWithLargestTotalPowerForInput_part2_Example2() {
        let result = findSquareWithLargestTotalPower(with: 42, gridSizeRange: 1...300)
        XCTAssert(result.coordinate.x == 232 && result.coordinate.y == 251 && result.gridSize == 12)
    }
}
