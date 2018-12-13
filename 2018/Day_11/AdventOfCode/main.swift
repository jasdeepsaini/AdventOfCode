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
    var cells: [[Int]] = Array(repeating: Array(repeating: 0, count: 301), count: 301)

    for y in 1...300 {
        for x in 1...300 {
            let coordinate = Coordinate(x: x, y: y)
            cells[x][y] = calculatePowerLevel(for: coordinate, serialNumber: serialNumber)
        }
    }


    var maxPower = Int.min
    var maxCoordinate = Coordinate(x: 0, y: 0)
    var gridSizeForMax = 0

    for y in 1...300 {
        for x in 1...300 {
            print("\(x) \(y)")

            // Guessing that a value less than 1 will not have the highest power
            if cells[x][y] <= 1 {
                continue
            }

            for gridSize in gridSizeRange {
                if x + (gridSize - 1) > 300 || y + (gridSize - 1) > 300 {
                    continue
                }

                var total = 0

                for offsetX in 0..<gridSize {
                    for offsetY in 0..<gridSize {
                        total += cells[x+offsetX][y+offsetY]
                    }
                }

                if total > maxPower {
                    maxPower = total
                    maxCoordinate = Coordinate(x: x, y: y)
                    gridSizeForMax = gridSize
                }
            }
        }
    }

    print(maxPower)
    return (coordinate: maxCoordinate, gridSize: gridSizeForMax)
}

func printGrid(_ grid: [String: Int]) {
    var string = ""
    for y in 1...300 {
        string = string + "\n"
        for x in 1...300 {
            let key = "\(x) \(y)"
            string = string + "\(grid[key] ?? 0) "
        }
    }

    print(string)
}
