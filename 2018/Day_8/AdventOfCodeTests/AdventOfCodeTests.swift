//
//  AdventOfCodeTests.swift
//  AdventOfCodeTests
//
//  Created by Jasdeep Saini on 12/9/18.
//  Copyright © 2018 Outsite Networks. All rights reserved.
//

import XCTest

class AdventOfCodeTests: XCTestCase {
    func testExample1ForGetNumbersFromString() {
        let string = example1String()
        let numbers = getNumbersFromString(string)

        XCTAssertEqual(numbers, [2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2])
    }

    func testExample1ForParseNodesFromNumbers() {
        let string = example1String()
        let numbers = ArraySlice(getNumbersFromString(string))
        let result = parseNodesFromNumbers(numbers)

        XCTAssertEqual(result.remainingNumbers, [])
        XCTAssertEqual(result.node.numberOfChildNodes, 2)
        XCTAssertEqual(result.node.numberOfMetaDataEntries, 3)
    }

    func testExample1ForComputeMetaDataEntryTotalForNode() {
        let string = example1String()
        let numbers = ArraySlice(getNumbersFromString(string))
        let node = parseNodesFromNumbers(numbers).node

        let metaDataTotal = computeMetaDataEntryTotalForNode(node, currentTotal: 0)

        XCTAssertEqual(metaDataTotal, 138)
    }

    func testInputForComputeMetaDataEntryTotalForNode() {
        let string = readInputFileAsString()
        let numbers = ArraySlice(getNumbersFromString(string))
        print("parsing nodes")
        let node = parseNodesFromNumbers(numbers).node

        print("Computing")
        let metaDataTotal = computeMetaDataEntryTotalForNode(node, currentTotal: 0)

        XCTAssertEqual(metaDataTotal, 48155)
    }

    func testExample1ForUpdateValueForNode() {
        let string = example1String()
        let numbers = ArraySlice(getNumbersFromString(string))
        let node = parseNodesFromNumbers(numbers).node
        updateValueForNode(node)

        XCTAssertEqual(node.value, 66)
    }

    func testInputForUpdateValueForNode() {
        let string = readInputFileAsString()
        let numbers = ArraySlice(getNumbersFromString(string))
        let node = parseNodesFromNumbers(numbers).node
        updateValueForNode(node)

        XCTAssertEqual(node.value, 40292)
    }

    func example1String() -> String {
        return "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2"
    }
}
