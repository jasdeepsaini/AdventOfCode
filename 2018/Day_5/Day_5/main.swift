//
//  main.swift
//  Day_5
//
//  Created by Jasdeep Saini on 12/9/18.
//  Copyright © 2018 Outsite Networks. All rights reserved.
//

import Foundation

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
            _ = newPolymer.popLast()
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

let polymer = "abc"
print(shortestPolymerByRemovingOneUnitFrom(polymer))
