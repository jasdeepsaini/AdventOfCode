import XCTest
import Foundation

func computeFrequencyFor(_ frequencies: [String]) -> Int {
    let result = frequencies.reduce(0) { (total, value) -> Int in
        let trimmedValue = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return total + (Int(trimmedValue) ?? 0)
    }

    return result
}

class CodeTests: XCTestCase {
    func testExample1() {
        let frequencies = ["+1", "-2", "+3", "+1"]
        XCTAssertEqual(computeFrequencyFor(frequencies), 3)
    }

    func testExample2() {
        let frequencies = ["+1", "+1", "+1"]
        XCTAssertEqual(computeFrequencyFor(frequencies), 3)
    }

    func testExample3() {
        let frequencies = ["+1", "+1", "-2"]
        XCTAssertEqual(computeFrequencyFor(frequencies), 0)
    }

    func testExample4() {
        let frequencies = ["-1", "-2", "-3"]
        XCTAssertEqual(computeFrequencyFor(frequencies), -6)
    }

}

//CodeTests.defaultTestSuite.run()

let fileUrl = Bundle.main.url(forResource: "Input", withExtension: "txt") ?? URL(fileURLWithPath: "")

do {
    let input = try String(contentsOf: fileUrl)
    let components = input.components(separatedBy: "\n")
    let frequency = computeFrequencyFor(components)
    print("frequency: \(frequency)")
} catch {
    print("Error reading file: \(error)")
}
