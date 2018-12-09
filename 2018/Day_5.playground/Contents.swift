import Foundation
import XCTest

typealias Polymer = String

func shortestPolymerByRemovingOneUnitFrom(_ initialPolymer: Polymer) -> Int {
    let characterSet = "abcdefghijklmnopqrstuvwxyz"
    let reducedPolymer = resultingPolymerFrom(initialPolymer)

    var minNumberOfUnits = Int.max

    for character in characterSet {
        if reducedPolymer.range(of: String(character), options: .caseInsensitive) != nil {
            let newPolymer = reducedPolymer.replacingOccurrences(of: String(character), with: "", options: .caseInsensitive)
            let resultingUnitCount = unitsInResultingPolymerFrom(newPolymer)

            if resultingUnitCount < minNumberOfUnits {
                minNumberOfUnits = resultingUnitCount
            }
            print("Result for: \(character) \(resultingUnitCount)")
        }
    }

    return minNumberOfUnits
}

func resultingPolymerFrom(_ initialPolymer: Polymer) -> String {
    //    print("Initial: \(initialPolymer)")
    var newPolymer = String()

    for character in initialPolymer {
        guard let lastCharacter = newPolymer.last else {
            newPolymer.append(character)
            continue
        }

        let previousCharacter = String(lastCharacter)
        let currentCharacter = String(character)

        if previousCharacter != currentCharacter && previousCharacter.lowercased() == currentCharacter.lowercased() {
            newPolymer.popLast()
        } else {
            newPolymer.append(currentCharacter)
        }
    }

    //    print("New: \(newPolymer)")

    return newPolymer
}

func unitsInResultingPolymerFrom(_ initialPolymer: Polymer) -> Int {
    let resultingPolymer = resultingPolymerFrom(initialPolymer)
    return resultingPolymer.count
}

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

CodeTest.defaultTestSuite.run()
