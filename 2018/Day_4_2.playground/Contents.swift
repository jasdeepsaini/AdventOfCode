import Foundation
import XCTest

let calendar = Calendar.current;
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

// ^\[([0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2})\] Guard #([0-9]{1,}) begins shift
let dateRegexString = "\\[([0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2})\\]"

let beginShiftRegexString = "^\(dateRegexString) Guard #([0-9]{1,}) begins shift"
let beginShiftRegex = try! NSRegularExpression(pattern: beginShiftRegexString, options: [])

let fallsAsleepRegexString = "^\(dateRegexString) falls asleep"
let fallsAsleepRegex = try! NSRegularExpression(pattern: fallsAsleepRegexString, options: [])

let wakesUpRegexString = "^\(dateRegexString) wakes up"
let wakesUpRegex = try! NSRegularExpression(pattern: wakesUpRegexString, options: [])

enum GuardAction {
    case beginShift(Int)
    case fallsAsleep(Int)
    case wakesUp(Int)
}

extension GuardAction: Equatable {}

func == (lhs: GuardAction, rhs: GuardAction) -> Bool {
    switch (lhs, rhs) {
    case (let .beginShift(id1), let .beginShift(id2)):
        return id1 == id2

    case (let .fallsAsleep(minute1), let .fallsAsleep(minute2)):
        return minute1 == minute2

    case (let .wakesUp(minute1), let .wakesUp(minute2)):
        return minute1 == minute2

    default:
        return false
    }
}

typealias ParsedAction = (date: Date, action: GuardAction)

func parseDate(_ dateString: String) -> Date? {
    let date = dateFormatter.date(from: dateString)
    return date
}

func parseBeginShiftActionString(_ actionString: String) -> ParsedAction? {
    let beginShiftMatches = beginShiftRegex.matches(in: actionString, options: [], range: NSRange(location: 0, length: actionString.count))

    if beginShiftMatches.count == 1 {
        let match = beginShiftMatches[0]

        let dateRange = match.range(at: 1)
        let dateString = (actionString as NSString).substring(with: dateRange)

        guard let date = parseDate(dateString) else {
            return nil
        }

        let idRange = match.range(at: 2)
        guard let id = Int((actionString as NSString).substring(with: idRange)) else {
            return nil
        }

        return (date: date, action: .beginShift(id))
    }

    return nil
}

func parseFallsAsleepActionString(_ actionString: String) -> ParsedAction? {
    let fallsAsleepMatches = fallsAsleepRegex.matches(in: actionString, options: [], range: NSRange(location: 0, length: actionString.count))

    if fallsAsleepMatches.count == 1 {
        let match = fallsAsleepMatches[0]

        let dateRange = match.range(at: 1)
        let dateString = (actionString as NSString).substring(with: dateRange)

        guard let date = parseDate(dateString) else {
            return nil
        }

        let minute = calendar.component(.minute, from: date)

        return (date: date, action: .fallsAsleep(minute))
    }

    return nil
}

func parseWakesUpActionString(_ actionString: String) -> ParsedAction? {
    let wakesUpMatches = wakesUpRegex.matches(in: actionString, options: [], range: NSRange(location: 0, length: actionString.count))

    if wakesUpMatches.count == 1 {
        let match = wakesUpMatches[0]

        let dateRange = match.range(at: 1)
        let dateString = (actionString as NSString).substring(with: dateRange)

        guard let date = parseDate(dateString) else {
            return nil
        }

        let minute = calendar.component(.minute, from: date)

        return (date: date, action: .wakesUp(minute))
    }

    return nil
}

func parseActionString(_ actionString: String) -> ParsedAction? {
    if let beginShiftAction = parseBeginShiftActionString(actionString) {
        return beginShiftAction
    }

    if let fallsAsleepAction = parseFallsAsleepActionString(actionString) {
        return fallsAsleepAction
    }

    if let wakesUpAction = parseWakesUpActionString(actionString) {
        return wakesUpAction
    }

    return nil
}

func parseActionStrings(_ actionStrings: [String]) -> [ParsedAction] {
    return actionStrings.compactMap { (actionString) -> ParsedAction? in
        return parseActionString(actionString)
    }
}

func sortParsedActions(_ parsedActions: [ParsedAction]) -> [ParsedAction] {
    return parsedActions.sorted(by: { (action1, action2) -> Bool in
        return action1.date.compare(action2.date) == .orderedAscending
    })
}

func findValueForStrategyOne(for actionStrings: [String]) -> Int {
    let parsedActions = parseActionStrings(actionStrings)
    let sortedActions = sortParsedActions(parsedActions)

    var guardSleepRecords = [Int: [Int: Int]]()

    var currentGuard = 0
    var fallsAsleepMinute = 0
    var maxMinute = (minute: 0, sleepLength: 0, guardId: 0)

    for parsedAction in sortedActions {
        switch parsedAction.action {
        case .beginShift(let guardId):
            currentGuard = guardId

        case .fallsAsleep(let minute):
            fallsAsleepMinute = minute

        case .wakesUp(let minute):
            if guardSleepRecords[currentGuard] == nil {
                guardSleepRecords[currentGuard] = [Int: Int]()
            }

            for min in fallsAsleepMinute..<minute {
                let previousSleepLength = guardSleepRecords[currentGuard]?[min] ?? 0
                let totalSleepLength = previousSleepLength + 1
                guardSleepRecords[currentGuard]?[min] = totalSleepLength

                if totalSleepLength > maxMinute.sleepLength {
                    maxMinute = (minute: min, sleepLength: totalSleepLength, guardId: currentGuard)
                }
            }
        }
    }

    print(maxMinute)

    return maxMinute.guardId * maxMinute.minute
}

class CodeTests: XCTestCase {
    func testParseDateForEmptyDateStringReturnsNil() {
        let dateString = ""
        XCTAssertNil(parseDate(dateString))
    }

    func testParseDateForInvalidDateReturnsNil() {
        let dateString = "1111-11-11 22:04am"
        XCTAssertNil(parseDate(dateString))
    }

    func testParseDateReturnsDate() {
        let dateString = "1518-11-01 13:25"
        let date = parseDate(dateString)!

        validateDate(date, year: 1518, month: 11, day: 1, hour: 13, minute: 25)
    }

    func testParseActionStringReturnsNilForEmptyString() {
        let actionString = ""
        let action = parseActionString(actionString)
        XCTAssertNil(action)
    }

    func testParseActionStringReturnsNilForInvalidAction() {
        let actionString = "abcdefghi"
        let action = parseActionString(actionString)
        XCTAssertNil(action)
    }

    func testParseActionStringForBeginsShift() {
        let actionString = "[1518-11-01 00:00] Guard #10 begins shift"
        let result = parseActionString(actionString)!

        XCTAssertEqual(result.action, .beginShift(10))
        validateDate(result.date, year: 1518, month: 11, day: 1, hour: 0, minute: 0)
    }

    func testParseActionStringForFallsAsleep() {
        let actionString = "[1518-11-03 00:24] falls asleep"
        let result = parseActionString(actionString)!

        XCTAssertEqual(result.action, .fallsAsleep(24))
        validateDate(result.date, year: 1518, month: 11, day: 3, hour: 0, minute: 24)
    }

    func testParseActionStringForWakesUp() {
        let actionString = "[1518-04-10 00:58] wakes up"
        let result = parseActionString(actionString)!

        XCTAssertEqual(result.action, .wakesUp(58))
        validateDate(result.date, year: 1518, month: 4, day: 10, hour: 0, minute: 58)
    }

    func testParseActions() {
        let action1 = "[1518-11-01 00:00] Guard #10 begins shift"
        let action2 = "[1518-11-03 00:24] falls asleep"
        let action3 = "[1518-04-10 00:58] wakes up"
        let action4 = "[1518-03-01 00:00] Guard #10 begins shift"
        let action5 = "[1518-05-15 00:24] falls asleep"
        let action6 = "[1510-02-09 00:24] falls asleep"
        let invalidAction = "[] abcd"

        let actions = [action1, action2, action3, invalidAction, action4, action5, action6]

        let expectedParsedActions = actions.compactMap { (actionString) -> ParsedAction? in
            return parseActionString(actionString)
        }

        let parsedActions = parseActionStrings(actions)

        for (index, action) in expectedParsedActions.enumerated() {
            XCTAssertEqual(action.date, parsedActions[index].date)
            XCTAssertEqual(action.action, parsedActions[index].action)
        }
    }

    func testSortParsedActions() {
        let action1 = parseActionString("[1518-11-01 00:00] Guard #10 begins shift")!
        let action2 = parseActionString("[1518-11-03 00:24] falls asleep")!
        let action3 = parseActionString("[1518-04-10 00:58] wakes up")!
        let action4 = parseActionString("[1518-03-01 00:00] Guard #10 begins shift")!
        let action5 = parseActionString("[1518-05-15 00:24] falls asleep")!
        let action6 = parseActionString("[1510-02-09 00:24] falls asleep")!

        let actionsToBeSorted = [action1, action2, action3, action4, action5, action6]
        let expectedSortedActions = [action6, action4, action3, action5, action1, action2]

        let sortedActions = sortParsedActions(actionsToBeSorted)

        for (index, action) in expectedSortedActions.enumerated() {
            XCTAssertEqual(action.date, sortedActions[index].date)
            XCTAssertEqual(action.action, sortedActions[index].action)
        }
    }

    func testExample1() {
        let actions = [
            "[1518-11-01 00:00] Guard #10 begins shift",
            "[1518-11-01 00:05] falls asleep",
            "[1518-11-01 00:25] wakes up",
            "[1518-11-01 00:30] falls asleep",
            "[1518-11-01 00:55] wakes up",
            "[1518-11-01 23:58] Guard #99 begins shift",
            "[1518-11-02 00:40] falls asleep",
            "[1518-11-02 00:50] wakes up",
            "[1518-11-03 00:05] Guard #10 begins shift",
            "[1518-11-03 00:24] falls asleep",
            "[1518-11-03 00:29] wakes up",
            "[1518-11-04 00:02] Guard #99 begins shift",
            "[1518-11-04 00:36] falls asleep",
            "[1518-11-04 00:46] wakes up",
            "[1518-11-05 00:03] Guard #99 begins shift",
            "[1518-11-05 00:45] falls asleep",
            "[1518-11-05 00:55] wakes up"]

        let result = findValueForStrategyOne(for: actions)
        XCTAssertEqual(result, 4455)
    }

    func testInput() {
        let input = readInputFile()

        let result = findValueForStrategyOne(for: input)
        XCTAssertEqual(result, 102095)
    }

    func dateComponents(for date: Date) -> DateComponents {
        return calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
    }

    func validateDate(_ date: Date, year: Int, month: Int, day: Int, hour: Int, minute: Int) {
        let components = dateComponents(for: date)

        XCTAssertEqual(components.year, year)
        XCTAssertEqual(components.month, month)
        XCTAssertEqual(components.day, day)
        XCTAssertEqual(components.hour, hour)
        XCTAssertEqual(components.minute, minute)
    }
}

print(beginShiftRegexString)
print(fallsAsleepRegexString)
print(wakesUpRegexString)
CodeTests.defaultTestSuite.run()
