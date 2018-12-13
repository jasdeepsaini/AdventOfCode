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

//    func testInitialStateForExample1() {
//        let string = example1String()
//        let initialState = initialStateForString(string)
//
//        XCTAssertEqual(initialState[0], "#")
//        XCTAssertEqual(initialState[1], ".")
//        XCTAssertEqual(initialState[2], ".")
//        XCTAssertEqual(initialState[3], "#")
//        XCTAssertEqual(initialState[4], ".")
//        XCTAssertEqual(initialState[5], "#")
//        XCTAssertEqual(initialState[6], ".")
//        XCTAssertEqual(initialState[7], ".")
//        XCTAssertEqual(initialState[8], "#")
//        XCTAssertEqual(initialState[9], "#")
//        XCTAssertEqual(initialState[10], ".")
//        XCTAssertEqual(initialState[11], ".")
//        XCTAssertEqual(initialState[12], ".")
//        XCTAssertEqual(initialState[13], ".")
//        XCTAssertEqual(initialState[14], ".")
//        XCTAssertEqual(initialState[15], ".")
//        XCTAssertEqual(initialState[16], "#")
//        XCTAssertEqual(initialState[17], "#")
//        XCTAssertEqual(initialState[18], "#")
//        XCTAssertEqual(initialState[19], ".")
//        XCTAssertEqual(initialState[20], ".")
//        XCTAssertEqual(initialState[21], ".")
//        XCTAssertEqual(initialState[22], "#")
//        XCTAssertEqual(initialState[23], "#")
//        XCTAssertEqual(initialState[24], "#")
//    }
//
//    func testConditionsForExample1() {
//        let string = example1String()
//        let conditions = conditionsForString(string)
//
//        XCTAssertEqual(conditions.count, 14)
//
//        XCTAssertTrue(conditions.contains(Condition(condition: "...##", result: "#")))
//        XCTAssertTrue(conditions.contains(Condition(condition: "..#..", result: "#")))
//        XCTAssertTrue(conditions.contains(Condition(condition: ".#...", result: "#")))
//        XCTAssertTrue(conditions.contains(Condition(condition: ".#.#.", result: "#")))
//        XCTAssertTrue(conditions.contains(Condition(condition: ".#.##", result: "#")))
//        XCTAssertTrue(conditions.contains(Condition(condition: ".##..", result: "#")))
//        XCTAssertTrue(conditions.contains(Condition(condition: ".####", result: "#")))
//        XCTAssertTrue(conditions.contains(Condition(condition: "#.#.#", result: "#")))
//        XCTAssertTrue(conditions.contains(Condition(condition: "#.###", result: "#")))
//        XCTAssertTrue(conditions.contains(Condition(condition: "##.#.", result: "#")))
//        XCTAssertTrue(conditions.contains(Condition(condition: "##.##", result: "#")))
//        XCTAssertTrue(conditions.contains(Condition(condition: "###..", result: "#")))
//        XCTAssertTrue(conditions.contains(Condition(condition: "###.#", result: "#")))
//        XCTAssertTrue(conditions.contains(Condition(condition: "####.", result: "#")))
//    }
//
//    func testGenerationsForExample1() {
//        let generations = [
//            "...#..#.#..##......###...###...........",
//            "...#...#....#.....#..#..#..#...........",
//            "...##..##...##....#..#..#..##..........",
//            "..#.#...#..#.#....#..#..#...#..........",
//            "...#.#..#...#.#...#..#..##..##.........",
//            "....#...##...#.#..#..#...#...#.........",
//            "....##.#.#....#...#..##..##..##........",
//            "...#..###.#...##..#...#...#...#........",
//            "...#....##.#.#.#..##..##..##..##.......",
//            "...##..#..#####....#...#...#...#.......",
//            "..#.#..#...#.##....##..##..##..##......",
//            "...#...##...#.#...#.#...#...#...#......",
//            "...##.#.#....#.#...#.#..##..##..##.....",
//            "..#..###.#....#.#...#....#...#...#.....",
//            "..#....##.#....#.#..##...##..##..##....",
//            "..##..#..#.#....#....#..#.#...#...#....",
//            ".#.#..#...#.#...##...#...#.#..##..##...",
//            "..#...##...#.#.#.#...##...#....#...#...",
//            "..##.#.#....#####.#.#.#...##...##..##..",
//            ".#..###.#..#.#.#######.#.#.#..#.#...#..",
//            ".#....##....#####...#######....#.#..##."
//        ]
//
//        let conditions = conditionsForString(example1String())
//
//        for (index, generationString) in generations.enumerated() {
//            if index == generations.count - 1 {
//                continue
//            }
//
//            var state = [Int: String]()
//
//            for index in -3...35 {
//                let stringIndex = generationString.index(generationString.startIndex, offsetBy: index + 3)
//                state[index] = String(generationString[stringIndex])
//            }
//
//            let generation = getNextGenerationForIntialState(state, conditions: conditions, min: -3, max: 35)
//
//            let expectedString = generations[index + 1]
//
//            for index in -3...35 {
//                let expectedResultIndex = expectedString.index(expectedString.startIndex, offsetBy: index + 3)
//                let expectedResult = String(expectedString[expectedResultIndex])
//
//                XCTAssertEqual(expectedResult, generation[index])
//            }
//
//            print("Generation: \(index + 1)")
//            print("\(expectedString)\n\(stateString(generation))")
//
//            if index == generations.count - 2 {
//                let sum = generation.reduce(0) { (total, state) -> Int in
//                    let newValue = state.value == "#" ? state.key : 0
//                    return total + newValue
//                }
//
//                print("Sum: \(sum)")
//                XCTAssertEqual(sum, 325)
//            }
//
//        }
//    }
//
//    func testStringForState() {
//        let string = example1String()
//        let initialState = initialStateForString(string)
//
//        let convertedString = stateString(initialState)
//
//        XCTAssertEqual(convertedString, "...#..#.#..##......###...###...........")
//    }
//
//    func testSubStringForIndex() {
//        let string = example1String()
//        let state = initialStateForString(string)
//
//        XCTAssertEqual(subStringForIndex(0, state: state), "..#..")
//        XCTAssertEqual(subStringForIndex(1, state: state), ".#..#")
//        XCTAssertEqual(subStringForIndex(2, state: state), "#..#.")
//        XCTAssertEqual(subStringForIndex(22, state: state), "..###")
//        XCTAssertEqual(subStringForIndex(23, state: state), ".###.")
//        XCTAssertEqual(subStringForIndex(24, state: state), "###..")
//    }

    func testGenerationsForInputFile() {
        let inputString = readInputFileAsString()

        var previousSum = 0
        var currentGeneration = initialStateForString(inputString)
        let conditions = conditionsForString(inputString)

        for index in 0..<50000000000 {
//            let nextGeneration = getNextGenerationForIntialState(currentGeneration, conditions: conditions, min: -20, max: currentGeneration.count + 10)
            let nextGeneration = getNextGenerationForIntialState(currentGeneration, conditions: conditions)

//            print("\(stateString(currentGeneration))\n\(stateString(nextGeneration))")

            let sum = nextGeneration.reduce(0) { (total, state) -> Int in
                let newValue = state.value == "#" ? state.key : 0
                return total + newValue
            }

            let diff = sum - previousSum
            print("Generation: \(index + 1) Sum: \(sum) Diff: \(diff)")

            previousSum = sum
            currentGeneration = nextGeneration
        }
    }

    // Stabilizes at a diff of 63 in Generation 125.  Answer is 3150000000905
}
//
//    func example1String() -> String {
//        return "initial state: #..#.#..##......###...###\n" +
//            "\n" +
//            "...## => #\n" +
//            "..#.. => #\n" +
//            ".#... => #\n" +
//            ".#.#. => #\n" +
//            ".#.## => #\n" +
//            ".##.. => #\n" +
//            ".#### => #\n" +
//            "#.#.# => #\n" +
//            "#.### => #\n" +
//            "##.#. => #\n" +
//            "##.## => #\n" +
//            "###.. => #\n" +
//            "###.# => #\n" +
//            "####. => #"
//    }
//}
