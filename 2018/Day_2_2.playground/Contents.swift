import Foundation
import XCTest

typealias TotalMatches = (twoMatches: Int, threeMatches: Int)

func computeDifferenceFor(_ ids: [String]) -> [Int] {
    guard ids.count == 2,
        ids[0].count == ids[1].count else {
        fatalError("Only 2 ids of equal length are allowed in this method")
    }

    let id1 = ids[0]
    let id2 = ids[1]

    var differenceIndexes = [Int]()
    for (i, value) in id1.enumerated() {
        let index = id2.index(id2.startIndex, offsetBy: i)
        if value != id2[index] {
            differenceIndexes.append(i)

            if differenceIndexes.count > 1 {
                break
            }
        }
    }

    return differenceIndexes
}

func findIdsWithDifferenceOne(_ ids: [String]) -> [String] {
    var foundIds = [String]()

    for (index, id1) in ids.enumerated() {
        for i in index..<ids.count {
            let id2Index = ids.index(ids.startIndex, offsetBy: i)
            let id2 = ids[id2Index]

            let difference = computeDifferenceFor([id1, id2]);

            if difference.count == 1 {
                print("Found: \(id1) \(id2)")
                foundIds = [id1, id2]
                break
            }
        }

        if (foundIds.count > 0) {
            break;
        }
    }

    return foundIds
}

func idWithoutDifference(_ ids: [String]) -> String {
    let foundIds = findIdsWithDifferenceOne(ids)
    let differences = computeDifferenceFor(foundIds)

    guard foundIds.count == 2, differences.count == 1 else { return "" }

    print(foundIds)
    print(differences)

    var id1 = foundIds[0]

    let differenceIndex = differences[0]

    let index = id1.index(id1.startIndex, offsetBy: differenceIndex)
    id1.remove(at: index)

    return id1
}

class CodeTests: XCTestCase {
    func testNoDifferenceBetweenStrings() {
        let ids = ["a", "a"]
        XCTAssertEqual(computeDifferenceFor(ids), [])
    }

    func testOneDifferenceBetweenStrings() {
        let ids = ["ab", "ac"]
        XCTAssertEqual(computeDifferenceFor(ids), [1])
    }

    func testMoreThanOneDifferenceBetweenStrings() {
        let ids = ["abcdefghij", "klmnopqrst"]
        XCTAssertEqual(computeDifferenceFor(ids), [0, 1])
    }

    func testExample1() {
        let ids = ["abcde", "fghij", "klmno", "pqrst", "fguij", "axcye", "wvxyz"];
        XCTAssertEqual(findIdsWithDifferenceOne(ids), ["fghij", "fguij"])
    }

    func testFindIdsForTestInput() {
        let ids = testInput()
        XCTAssertEqual(findIdsWithDifferenceOne(ids), ["lufjygedpvfbhftaxiwnaorzmq", "lufjygedpvfbhftbxiwnaorzmq"])
    }

    func testFindIdsWithoutDifferenceForTestInput() {
        let ids = testInput()
        XCTAssertEqual(idWithoutDifference(ids), "lufjygedpvfbhftxiwnaorzmq")
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
