//
//  main.swift
//  AdventOfCode
//
//  Created by Jasdeep Saini on 12/9/18.
//  Copyright © 2018 Outsite Networks. All rights reserved.
//

import Foundation

class Coordinate: Hashable {
    let x: Int
    let y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    var hashValue: Int {
        return x ^ y
    }
}

func calculatePowerLevel(for coordinate: Coordinate, serialNumber: Int) -> Int {
    let rackId = coordinate.x + 10
    var powerLevel = rackId * coordinate.y
    powerLevel = powerLevel + serialNumber
    powerLevel = powerLevel * rackId

    let powerLevelString = String(powerLevel)

    let stringLength = powerLevelString.count
    let index = stringLength - 3

    var hundreds = 0

    if index >= 0 {
        let stringIndex = powerLevelString.index(powerLevelString.startIndex, offsetBy: index)
        hundreds = Int(String(powerLevelString[stringIndex])) ?? 0
    }

    return hundreds - 5
}

func findSquareWithLargestTotalPower(with serialNumber: Int, gridSizeRange: ClosedRange<Int>) -> (coordinate: Coordinate, gridSize: Int) {
    var partialSums: [[Int]] = Array(repeating: Array(repeating: 0, count: 301), count: 301)

    for y in 1...300 {
        for x in 1...300 {
            let coordinate = Coordinate(x: x, y: y)
            let power = calculatePowerLevel(for: coordinate, serialNumber: serialNumber)

            let leftValue = partialSums[x - 1][y]
            let upValue = partialSums[x][y - 1]
            let diagonalValue = partialSums[x - 1][y - 1]

            partialSums[x][y] = power + leftValue + upValue - diagonalValue
        }
    }

    var maxPower = Int.min
    var maxCoordinate = Coordinate(x: 0, y: 0)
    var gridSizeForMax = 0

    for gridSize in gridSizeRange {
        for y in gridSize...300 {
            for x in gridSize...300 {
                let total = partialSums[x][y] - partialSums[x][y - gridSize] - partialSums[x - gridSize][y] + partialSums[x - gridSize][y - gridSize]

                if total > maxPower {
                    maxPower = total
                    maxCoordinate = Coordinate(x: x, y: y)
                    gridSizeForMax = gridSize
                }
            }
        }
    }

    let convertedCoordinate = Coordinate(x: maxCoordinate.x - gridSizeForMax + 1, y: maxCoordinate.y - gridSizeForMax + 1)
    return (coordinate: convertedCoordinate, gridSize: gridSizeForMax)
}
