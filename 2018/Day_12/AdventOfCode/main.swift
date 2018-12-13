//
//  main.swift
//  AdventOfCode
//
//  Created by Jasdeep Saini on 12/9/18.
//  Copyright © 2018 Outsite Networks. All rights reserved.
//

import Foundation

struct Condition: Equatable, Hashable {
    let condition: String
    let result: String

    // Not checking the result to make it easier to find the condition in a set without testing for negative and positive results.
    static func == (lhs: Condition, rhs: Condition) -> Bool {
        return lhs.condition == rhs.condition
    }
}

var initialStateRegex: NSRegularExpression!
var conditionsRegex: NSRegularExpression!

func setUpRegex() {
    let initialStateRegexString = "^initial state: ([#.]+)"
    let conditionsRegexString = "([#.]{5}) => ([#.]{1})"

    initialStateRegex = try! NSRegularExpression(pattern: initialStateRegexString, options: [])
    conditionsRegex = try! NSRegularExpression(pattern: conditionsRegexString, options: [])
}

func initialStateForString(_ string: String) -> [Int: String] {
    let match = initialStateRegex.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.count))

    if let initialStateRange = match?.range(at: 1) {
        let initialStateString = (string as NSString).substring(with: initialStateRange)

        var initialState = [Int: String]()

        for (index, character) in initialStateString.enumerated() {
            initialState[index] = String(character)
        }
//
//
//        for index in -3..<0 {
//            initialState[index] = "."
//        }
//
//
//        for index in string.count...string.count + 10 {
//            initialState[index] = "."
//        }

        return initialState
    } else {
        fatalError("Initial State not found")
    }
}

func conditionsForString(_ string: String) -> Set<Condition> {
    let match = conditionsRegex.matches(in: string, options: [], range: NSRange(location: 0, length: string.count))

    return Set(match.map({ result -> Condition in
        let range1 = result.range(at: 1)
        let range2 = result.range(at: 2)
        return Condition(condition: (string as NSString).substring(with: range1), result: (string as NSString).substring(with: range2))
    }))
}

func getNextGenerationForIntialState(_ initialState: [Int: String], conditions: Set<Condition>) -> [Int: String] {
    var nextGeneration = [Int: String]()

    let sortedKeys = initialState.keys.sorted()
    var min = (sortedKeys.min() ?? 0) - 2
    let max = (sortedKeys.max() ?? 0) + 2

    for index in min...max {
        let nextConditionString = subStringForIndex(index, state: initialState)

        if let condition = conditions.first(where: { $0.condition == nextConditionString }) {
            nextGeneration[index] = condition.result
        } else {
            nextGeneration[index] = "."
        }
    }

    return nextGeneration
}

//func getNextGenerationForIntialState(_ initialState: [Int: String], conditions: Set<Condition>, min: Int, max: Int) -> [Int: String] {
//    var nextGeneration = [Int: String]()
//
//    for index in min...max {
//        let nextConditionString = subStringForIndex(index, state: initialState)
//
//        if let condition = conditions.first(where: { $0.condition == nextConditionString }) {
//            nextGeneration[index] = condition.result
//        } else {
//            nextGeneration[index] = "."
//        }
//    }
//
//    return nextGeneration
//}

func subStringForIndex(_ index: Int, state: [Int: String]) -> String{
    var characters = [String]()
    for i in (index - 2)...(index + 2) {
        characters.append(state[i] ?? ".")
    }

    return characters.joined()
}

func stateString(_ state:[Int: String]) -> String {
    let sortedKeys = state.keys.sorted()

    let result = sortedKeys.map { index -> String in
        return state[index] ?? ""
    }

    return result.joined()
}
