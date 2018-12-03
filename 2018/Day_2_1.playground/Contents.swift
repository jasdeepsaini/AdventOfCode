import Foundation
import XCTest

typealias TotalMatches = (twoMatches: Int, threeMatches: Int)

func computeCheckSumFor(_ ids: [String]) -> Int {
    let matches = ids.map { (id) ->  TotalMatches in
        return computeMatchesFor(id)
    }

    let totalMatches = matches.reduce((twoMatches: 0, threeMatches: 0)) { (total, match) -> TotalMatches in
        return (total.twoMatches + match.twoMatches, total.threeMatches + match.threeMatches)
    }

    return totalMatches.twoMatches * totalMatches.threeMatches
}

func computeMatchesFor(_ id: String) -> TotalMatches {
    var characterCount = [Character: Int]()

    for character in id {
        characterCount[character] = (characterCount[character] ?? 0) + 1
    }


    let twoCharacterMarch = characterCount.first { (character, value) -> Bool in
        return value == 2
    }

    let threeCharacterMarch = characterCount.first { (character, value) -> Bool in
        return value == 3
    }

    let hasTwoCharacterMatches = twoCharacterMarch != nil;
    let hasThreeCharacterMatch = threeCharacterMarch != nil;

    return (twoMatches: hasTwoCharacterMatches ? 1: 0, threeMatches: hasThreeCharacterMatch ? 1: 0)
}

class CodeTests: XCTestCase {
    func testNoMatchesForEmptyString() {
        let matches = computeMatchesFor("")
        XCTAssertEqual(matches.twoMatches, 0)
        XCTAssertEqual(matches.threeMatches, 0)
    }

    func testNoMatchesForSingleLetter() {
        let matches = computeMatchesFor("a")
        XCTAssertEqual(matches.twoMatches, 0)
        XCTAssertEqual(matches.threeMatches, 0)
    }

    func testNoMatchesForLongString() {
        let matches = computeMatchesFor("abcdefghijklmnopqrstuvwxyz")
        XCTAssertEqual(matches.twoMatches, 0)
        XCTAssertEqual(matches.threeMatches, 0)
    }

    func testTwoCharacterMatch() {
        let matches = computeMatchesFor("aa")
        XCTAssertEqual(matches.twoMatches, 1)
        XCTAssertEqual(matches.threeMatches, 0)
    }

    func testMultipleTwoCharacterMatches() {
        let matches = computeMatchesFor("aabb")
        XCTAssertEqual(matches.twoMatches, 1)
        XCTAssertEqual(matches.threeMatches, 0)
    }

    func testThreeCharacterMatch() {
        let matches = computeMatchesFor("aaa")
        XCTAssertEqual(matches.twoMatches, 0)
        XCTAssertEqual(matches.threeMatches, 1)
    }

    func testMultipleThreeCharacterMatches() {
        let matches = computeMatchesFor("aaabbb")
        XCTAssertEqual(matches.twoMatches, 0)
        XCTAssertEqual(matches.threeMatches, 1)
    }

    func testExample1() {
        let matches = computeMatchesFor("abcdef")
        XCTAssertEqual(matches.twoMatches, 0)
        XCTAssertEqual(matches.threeMatches, 0)
    }

    func testExample2() {
        let matches = computeMatchesFor("bababc")
        XCTAssertEqual(matches.twoMatches, 1)
        XCTAssertEqual(matches.threeMatches, 1)
    }

    func testExample3() {
        let matches = computeMatchesFor("abbcde")
        XCTAssertEqual(matches.twoMatches, 1)
        XCTAssertEqual(matches.threeMatches, 0)
    }

    func testExample4() {
        let matches = computeMatchesFor("abcccd")
        XCTAssertEqual(matches.twoMatches, 0)
        XCTAssertEqual(matches.threeMatches, 1)
    }

    func testExample5() {
        let matches = computeMatchesFor("aabcdd")
        XCTAssertEqual(matches.twoMatches, 1)
        XCTAssertEqual(matches.threeMatches, 0)
    }

    func testExample6() {
        let matches = computeMatchesFor("abcdee")
        XCTAssertEqual(matches.twoMatches, 1)
        XCTAssertEqual(matches.threeMatches, 0)
    }

    func testExample7() {
        let matches = computeMatchesFor("ababab")
        XCTAssertEqual(matches.twoMatches, 0)
        XCTAssertEqual(matches.threeMatches, 1)
    }

    func testCheckSumForEmptyArray() {
        let checkSum = computeCheckSumFor([])
        XCTAssertEqual(checkSum, 0)
    }

    func testCheckSumForNoMatches() {
        let checkSum = computeCheckSumFor(["a"])
        XCTAssertEqual(checkSum, 0)
    }

    func testCheckSumForSingleTwoMatch() {
        let checkSum = computeCheckSumFor(["aa"])
        XCTAssertEqual(checkSum, 0)
    }

    func testCheckSumForSingleThreeMatch() {
        let checkSum = computeCheckSumFor(["aaa"])
        XCTAssertEqual(checkSum, 0)
    }

    func testCheckSumForSingleTwoMatchAndSingleThreeMatch() {
        let checkSum = computeCheckSumFor(["aa", "bbb"])
        XCTAssertEqual(checkSum, 1)
    }

    func testCheckSumForExample1() {
        let ids = ["abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab"]
        let checkSum = computeCheckSumFor(ids)
        XCTAssertEqual(checkSum, 12)
    }

    func testCheckSumForTestInput() {
        let ids = testInput()
        let checkSum = computeCheckSumFor(ids)
        XCTAssertEqual(checkSum, 4712)
    }

    private func testInput() -> [String] {
        let fileUrl = Bundle.main.url(forResource: "Input", withExtension: "txt") ?? URL(fileURLWithPath: "")

        var components: [String] = []
        do {
            let input = try String(contentsOf: fileUrl)
            components = input.components(separatedBy: "\n")
        } catch {
            print("Error reading file: \(error)")
        }

        return components
    }
}

CodeTests.defaultTestSuite.run()

//let fileUrl = Bundle.main.url(forResource: "Input", withExtension: "txt") ?? URL(fileURLWithPath: "")
//
//do {
//    let input = try String(contentsOf: fileUrl)
//    let ids = input.components(separatedBy: "\n")
//    let checkSum = computeCheckSumFor(ids)
//
//    print(checkSum)
//} catch {
//    print("Error reading file: \(error)")
//}
//
