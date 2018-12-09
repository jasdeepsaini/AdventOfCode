//
//  Day_5_Tests.swift
//  Day_5_Tests
//
//  Created by Jasdeep Saini on 12/9/18.
//  Copyright © 2018 Outsite Networks. All rights reserved.
//

import XCTest

class CodeTest: XCTestCase {
    func testEmptyPolymer() {
        let polymer = ""
        XCTAssertEqual(unitsInResultingPolymerFrom(polymer), 0)
    }

    func testSingleUnitPolymer() {
        let polymer = "A"
        XCTAssertEqual(unitsInResultingPolymerFrom(polymer), 1)
    }

    func testUnreactivePolymer() {
        let polymer = "AA"
        XCTAssertEqual(unitsInResultingPolymerFrom(polymer), 2)
    }

    func testReactivePolymer() {
        let polymer = "Aa"
        XCTAssertEqual(unitsInResultingPolymerFrom(polymer), 0)
    }

    func testReactivePolymer2() {
        let polymer = "AABB"
        XCTAssertEqual(unitsInResultingPolymerFrom(polymer), 4)
    }

    func testReactivePolymer3() {
        let polymer = "aAbB"
        XCTAssertEqual(unitsInResultingPolymerFrom(polymer), 0)
    }

    func testExample1_part1() {
        let polymer = "dabAcCaCBAcCcaDA"
        XCTAssertEqual(unitsInResultingPolymerFrom(polymer), 10)
    }

    func testInput_part1() {
        let polymer = readInputFile()
        XCTAssertEqual(unitsInResultingPolymerFrom(polymer), 9704)
    }

    func testExample1_part2() {
        let polymer = "dabAcCaCBAcCcaDA"
        XCTAssertEqual(shortestPolymerByRemovingOneUnitFrom(polymer), 4)
    }

    func testInput_part2() {
        let polymer = readInputFile()
        XCTAssertEqual(shortestPolymerByRemovingOneUnitFrom(polymer), 6942)
    }
}
