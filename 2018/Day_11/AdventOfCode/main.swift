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
    var cells = [Coordinate: Int]()

    for y in 1...300 {
        for x in 1...300 {
            let coordinate = Coordinate(x: x, y: y)
            cells[coordinate] = calculatePowerLevel(for: coordinate, serialNumber: serialNumber)
        }
    }

//    printGrid(cells)

    var maxPower = Int.min
    var maxCoordinate = Coordinate(x: 0, y: 0)
    var gridSizeForMax = 0

    for (coordinate, _) in cells {
        for gridSize in gridSizeRange {
            if coordinate.x + (gridSize - 1) > 300 || coordinate.y + (gridSize - 1) > 300 {
                continue
            }

            var total = 0

            for offsetX in 0..<gridSize {
                for offsetY in 0..<gridSize {
                    let coordinate = Coordinate(x: coordinate.x + offsetX, y: coordinate.y + offsetY)
                    total += cells[coordinate] ?? 0
                }
            }

            if total > maxPower {
                maxPower = total
                maxCoordinate = coordinate
                gridSizeForMax = gridSize
            }
        }
//        print("\(coordinate.x), \(coordinate.y): \(value)")
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
