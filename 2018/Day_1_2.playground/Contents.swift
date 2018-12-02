import XCTest
import Foundation

func convertStringArrayToIntArray(stringArray: [String]) -> [Int] {
    let intArray = stringArray.map { (string) -> Int in
        let trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        return Int(trimmedString) ?? 0
    }

    return intArray
}

func firstRepeatedResultFrequencyFor_Set(_ frequencies: [String]) -> Int {
    var previousFrequencies: Set = [0]

    var total = 0
    var repeatFound = false

    let intFrequencies = convertStringArrayToIntArray(stringArray: frequencies)

    while repeatFound == false {
        for frequency in intFrequencies {
            total = total + frequency

            if previousFrequencies.contains(total) {
                repeatFound = true
                break;
            } else {
                previousFrequencies.insert(total)
            }
        }
    }

    return total
}

func firstRepeatedResultFrequencyFor_Dictionary(_ frequencies: [String]) -> Int {
    var previousFrequencies = [0: true]

    var total = 0
    var repeatFound = false

    let intFrequencies = convertStringArrayToIntArray(stringArray: frequencies)

    while repeatFound == false {
        for frequency in intFrequencies {
            total = total + frequency

            if let _ = previousFrequencies[total] {
                repeatFound = true
                break;
            } else {
                previousFrequencies[total] = true
            }
        }
    }

    return total
}

func firstRepeatedResultFrequencyFor_Array(_ frequencies: [String]) -> Int {
    var previousFrequencies = [0]

    var total = 0
    var repeatFound = false

    let intFrequencies = convertStringArrayToIntArray(stringArray: frequencies)

    while repeatFound == false {
        for frequency in intFrequencies {
            total = total + frequency

            if previousFrequencies.contains(total) {
                repeatFound = true
                break;
            } else {
                previousFrequencies.append(total)
            }
        }
    }

    return total
}

class CodeTests: XCTestCase {
//    func testExample1() {
//        let frequencies = ["+1", "-2", "+3", "+1"]
//        XCTAssertEqual(firstRepeatedResultFrequencyFor_Set(frequencies), 2)
//    }
//
//    func testExample2() {
//        let frequencies = ["+1", "-1"]
//        XCTAssertEqual(firstRepeatedResultFrequencyFor_Set(frequencies), 0)
//    }
//
//    func testExample3() {
//        let frequencies = ["+3", "+3", "+4", "-2", "-4"]
//        XCTAssertEqual(firstRepeatedResultFrequencyFor_Set(frequencies), 10)
//    }
//
//    func testExample4() {
//        let frequencies = ["-6", "+3", "+8", "+5", "-6"]
//        XCTAssertEqual(firstRepeatedResultFrequencyFor_Set(frequencies), 5)
//    }
//
//    func testExample5() {
//        let frequencies = ["+7", "+7", "-2", "-7", "-4"]
//        XCTAssertEqual(firstRepeatedResultFrequencyFor_Set(frequencies), 14)
//    }

    //  average: 8.112
    //  relative standard deviation: 5.256%
    //  values: [8.795004, 7.684969, 7.831459, 7.843974, 8.092718, 8.563294, 8.789081, 7.770133, 7.623490, 8.128200]
    //  maxPercentRegression: 10.000%
    //  maxPercentRelativeStandardDeviation: 10.000%
    //  maxRegression: 0.100
    //  maxStandardDeviation: 0.100
    //  passed (81.379 seconds).
    func testSetPerformance() {
        let frequencies = testInput()

        measure {
            let frequency = firstRepeatedResultFrequencyFor_Set(frequencies)
            XCTAssertEqual(frequency, 75108)
        }
    }

    //  average: 5.747
    //  relative standard deviation: 8.586%
    //  values: [6.529345, 6.396388, 5.697647, 5.341767, 6.018142, 4.944916, 6.217182, 5.505310, 5.349321, 5.465108]
    //  maxPercentRegression: 10.000%
    //  maxPercentRelativeStandardDeviation: 10.000%
    //  maxRegression: 0.100
    //  maxStandardDeviation: 0.100
    //  passed (58.670 seconds).
    func testDictionaryPerformance() {
        let frequencies = testInput()

        measure {
            let frequency = firstRepeatedResultFrequencyFor_Dictionary(frequencies)
            XCTAssertEqual(frequency, 75108)
        }
    }

    // Can't finish the run for this one.  Computer crashes after a hour.
//    func testArrayPerformance() {
//        let frequencies = testInput()
//
//        measure {
//            let frequency = firstRepeatedResultFrequencyFor_Array(frequencies)
//            XCTAssertEqual(frequency, 75108)
//        }
//    }

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

//CodeTests.defaultTestSuite.run()

let fileUrl = Bundle.main.url(forResource: "Input", withExtension: "txt") ?? URL(fileURLWithPath: "")

do {
    let input = try String(contentsOf: fileUrl)
    let components = input.components(separatedBy: "\n")
    let frequency = firstRepeatedResultFrequencyFor_Dictionary(components)
    print("frequency: \(frequency)")
} catch {
    print("Error reading file: \(error)")
}
