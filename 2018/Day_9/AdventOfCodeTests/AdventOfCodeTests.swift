//
//  AdventOfCodeTests.swift
//  AdventOfCodeTests
//
//  Created by Jasdeep Saini on 12/9/18.
//  Copyright © 2018 Outsite Networks. All rights reserved.
//

import XCTest

class AdventOfCodeTests: XCTestCase {
    func testHighScoreForExample1() {
        let score = highScore(for: 9, finalMarbleValue: 32)
        XCTAssertEqual(score, 32)
    }

    func testHighScoreForExample2() {
        let score = highScore(for: 10, finalMarbleValue: 1618)
        XCTAssertEqual(score, 8317)
    }

    func testHighScoreForExample3() {
        let score = highScore(for: 13, finalMarbleValue: 7999)
        XCTAssertEqual(score, 146373)
    }

    func testHighScoreForExample4() {
        let score = highScore(for: 17, finalMarbleValue: 1104)
        XCTAssertEqual(score, 2764)
    }

    func testHighScoreForExample5() {
        let score = highScore(for: 21, finalMarbleValue: 6111)
        XCTAssertEqual(score, 54718)
    }

    func testHighScoreForExample6() {
        let score = highScore(for: 30, finalMarbleValue: 5807)
        XCTAssertEqual(score, 37305)
    }

    func testHighScoreForInput() {
        let score = highScore(for: 459, finalMarbleValue: 71790)
        XCTAssertEqual(score, 386151)
    }

    func testHighScoreForInput_Part2() {
        let score = highScore(for: 459, finalMarbleValue: 71790 * 100)
        XCTAssertEqual(score, 3211264152)
    }
}
