//
//  AdventOfCodeTests.swift
//  AdventOfCodeTests
//
//  Created by Jasdeep Saini on 12/9/18.
//  Copyright © 2018 Outsite Networks. All rights reserved.
//

import XCTest

class AdventOfCodeTests: XCTestCase {
    override func setUp() {
        super.setUp()

        setUpRegex()
    }

    func testParseStringsForExample() {
        let strings = exampleStrings()
        let lights = parseStrings(strings)

        XCTAssertEqual(lights[0], Light(initialX: 9, initialY: 1, velocityX: 0, velocityY: 2))
        XCTAssertEqual(lights[1], Light(initialX: 7, initialY: 0, velocityX: -1, velocityY: 0))
        XCTAssertEqual(lights[2], Light(initialX: 3, initialY: -2, velocityX: -1, velocityY: 1))
        XCTAssertEqual(lights.last, Light(initialX: -3, initialY: 6, velocityX: 2, velocityY: -1))

        XCTAssertEqual(lights.count, 31)
    }

    func testBoundingAreaAtSecondForExample() {
        let strings = exampleStrings()
        let lights = parseStrings(strings)

        print(boundingAreaAtSecond(0, for: lights).area)
        print(boundingAreaAtSecond(1, for: lights).area)
        print(boundingAreaAtSecond(2, for: lights).area)
        print(boundingAreaAtSecond(3, for: lights).area)
        print(boundingAreaAtSecond(4, for: lights).area)
        print(boundingAreaAtSecond(5, for: lights).area)
        print(boundingAreaAtSecond(6, for: lights).area)
    }

    func testParseStringsForInput() {
        let strings = readInputFileAsArrayOfStrings()
        let lights = parseStrings(strings)

        XCTAssertEqual(lights.count, 365)
    }

    func testBoundingAreaAtSecondForInput() {
        let strings = readInputFileAsArrayOfStrings()
        let lights = parseStrings(strings)

        var previousArea = Int.max
        var sizeIsIncreasing = false
        var second = 0
        var previousResult: (result: [String: Light], area: Int, minX: Int, maxX: Int, minY: Int, maxY: Int)!

        while sizeIsIncreasing == false {
            let result = boundingAreaAtSecond(second, for: lights)
            let area = result.area
            print("\(second): \(area)")

            if (area > previousArea) {
                sizeIsIncreasing = true
            } else {
                previousResult = result
            }

            second = second + 1
            previousArea = area
        }

        displayLights(previousResult.result, minX: previousResult.minX, maxX: previousResult.maxX, minY: previousResult.minY, maxY: previousResult.maxY)

        // Part 1 Result: A B G X J B X F
        // Part 2 Result: 10619
    }

    func exampleStrings() -> [String] {
        return [
            "position=< 9,  1> velocity=< 0,  2>",
            "position=< 7,  0> velocity=<-1,  0>",
            "position=< 3, -2> velocity=<-1,  1>",
            "position=< 6, 10> velocity=<-2, -1>",
            "position=< 2, -4> velocity=< 2,  2>",
            "position=<-6, 10> velocity=< 2, -2>",
            "position=< 1,  8> velocity=< 1, -1>",
            "position=< 1,  7> velocity=< 1,  0>",
            "position=<-3, 11> velocity=< 1, -2>",
            "position=< 7,  6> velocity=<-1, -1>",
            "position=<-2,  3> velocity=< 1,  0>",
            "position=<-4,  3> velocity=< 2,  0>",
            "position=<10, -3> velocity=<-1,  1>",
            "position=< 5, 11> velocity=< 1, -2>",
            "position=< 4,  7> velocity=< 0, -1>",
            "position=< 8, -2> velocity=< 0,  1>",
            "position=<15,  0> velocity=<-2,  0>",
            "position=< 1,  6> velocity=< 1,  0>",
            "position=< 8,  9> velocity=< 0, -1>",
            "position=< 3,  3> velocity=<-1,  1>",
            "position=< 0,  5> velocity=< 0, -1>",
            "position=<-2,  2> velocity=< 2,  0>",
            "position=< 5, -2> velocity=< 1,  2>",
            "position=< 1,  4> velocity=< 2,  1>",
            "position=<-2,  7> velocity=< 2, -2>",
            "position=< 3,  6> velocity=<-1, -1>",
            "position=< 5,  0> velocity=< 1,  0>",
            "position=<-6,  0> velocity=< 2,  0>",
            "position=< 5,  9> velocity=< 1, -2>",
            "position=<14,  7> velocity=<-2,  0>",
            "position=<-3,  6> velocity=< 2, -1>"
        ]
    }
}
