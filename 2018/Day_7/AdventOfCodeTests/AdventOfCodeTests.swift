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

    func testValueForLetter() {
        XCTAssertEqual(valueForLetter("A"), 1)
        XCTAssertEqual(valueForLetter("C"), 3)
        XCTAssertEqual(valueForLetter("X"), 24)
        XCTAssertEqual(valueForLetter("Z"), 26)
    }

    func testParseInvalidString() {
        let string = "Step must be finished before step can begin."
        XCTAssertNil(parseDependencyString(string))
    }

    func testParseString() {
        let string = "Step A must be finished before step B can begin."
        let parsedNode = parseDependencyString(string)
        XCTAssertEqual(parsedNode?.nodeName, "B")
        XCTAssertEqual(parsedNode?.edge, "A")
    }

    func testNodesForDependencyStringForExample1() {
        let strings = example1Strings()
        let nodeDictionary = nodesForDependencyStrings(strings)

        XCTAssertEqual(nodeDictionary["A"]?.edges.first, "C")
        XCTAssertEqual(nodeDictionary["C"]?.edges, [])
        XCTAssertEqual(nodeDictionary["F"]?.edges.first, "C")

        XCTAssertNotNil(nodeDictionary["B"]!.edges.first(where: { $0 == "A" }))
        XCTAssertNotNil(nodeDictionary["D"]!.edges.first(where: { $0 == "A" }))

        XCTAssertNotNil(nodeDictionary["E"]!.edges.first(where: { $0 == "B" }))
        XCTAssertNotNil(nodeDictionary["E"]!.edges.first(where: { $0 == "D" }))
        XCTAssertNotNil(nodeDictionary["E"]!.edges.first(where: { $0 == "F" }))
    }

    func testResolveNodeDictionaryForExample1() {
        let strings = example1Strings()
        let nodeDictionary = nodesForDependencyStrings(strings)

        XCTAssertEqual(resolveNodeDictionary(nodeDictionary), "CABDFE")
    }

    func testResolveNodeDictionaryForInput() {
        let strings = readInputFileAsArrayOfStrings()
        let nodeDictionary = nodesForDependencyStrings(strings)

        XCTAssertEqual(resolveNodeDictionary(nodeDictionary), "BGJCNLQUYIFMOEZTADKSPVXRHW")
    }

    func testResolveNodeDictionaryWithHelpersForExample1() {
        let strings = example1Strings()
        let nodeDictionary = nodesForDependencyStrings(strings)

        XCTAssertEqual(resolveNodeDictionaryWithHelpers(nodeDictionary, numberOfHelpers: 1, additionalSecondsPerStep: 0), 15)
    }

    func testResolveNodeDictionaryWithHelpersForInput() {
        let strings = readInputFileAsArrayOfStrings()
        let nodeDictionary = nodesForDependencyStrings(strings)

        XCTAssertEqual(resolveNodeDictionaryWithHelpers(nodeDictionary, numberOfHelpers: 5, additionalSecondsPerStep: 60), 1017)
    }

    func example1Strings() -> [String] {
        return [
            "Step C must be finished before step A can begin.",
            "Step C must be finished before step F can begin.",
            "Step A must be finished before step B can begin.",
            "Step A must be finished before step D can begin.",
            "Step B must be finished before step E can begin.",
            "Step D must be finished before step E can begin.",
            "Step F must be finished before step E can begin."
        ]
    }
}
