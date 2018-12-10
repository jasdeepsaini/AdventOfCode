//
//  main.swift
//  AdventOfCode
//
//  Created by Jasdeep Saini on 12/9/18.
//  Copyright © 2018 Outsite Networks. All rights reserved.
//

struct Coordinate: Hashable {
    let x: Int
    let y: Int

    var hashValue: Int {
        return x.hashValue ^ y.hashValue
    }

    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

typealias CoordinateName = String
typealias Grid = [Coordinate: CoordinateName]

func coordinateForString(_ string: String) -> Coordinate {
    // TODO: Add guards to ensure string is formatted correctly

    let components = string.components(separatedBy: ", ")
    return Coordinate(x: Int(components[0]) ?? 0, y: Int(components[1]) ?? 0)
}
func manhattanDistanceBetween(_ coordinate1: Coordinate, coordinate2: Coordinate) -> Int {
    return abs(coordinate1.x - coordinate2.x) + abs(coordinate1.y - coordinate2.y)
}

func getCoordinateName(at index: Int) -> String {
    let letterIndex = index % 26
    let scalar = 97 + letterIndex
    let numberOfLetters = (index / 26) + 1

    guard let letter = UnicodeScalar(scalar) else {
        fatalError("Unable to create Coordinate Name")
    }

    return String(repeating: Character(letter), count: numberOfLetters).uppercased()
}

func gridForCoordinates(_ coordinates: [Coordinate]) -> Grid {
    var grid = Grid()

    for (index, coordinate) in coordinates.enumerated() {
        grid[coordinate] = getCoordinateName(at: index)
    }

    return grid
}

func getMaxXInGrid(_ grid: Grid) -> Int {
    return grid.map({ (coordinate, _) -> Int in
        return coordinate.x
    }).max() ?? 0
}

func getMaxYInGrid(_ grid: Grid) -> Int {
    return grid.map({ (coordinate, _) -> Int in
        return coordinate.y
    }).max() ?? 0
}

func gridWithClosestCoordinatesForGrid(_ grid: Grid) -> Grid {
    var gridWithClosestCoordinates = Grid()

    let maxX = getMaxXInGrid(grid) + 1
    let maxY = getMaxYInGrid(grid) + 1

    for x in 0...maxX {
        for y in 0...maxY {
            let coordinate = Coordinate(x: x, y: y)
//            print(coordinate)
            if grid.keys.contains(coordinate) {
                gridWithClosestCoordinates[coordinate] = grid[coordinate]
                continue
            }

            var minDistance = Int.max

            for (gridCoordinate, coordinateName) in grid {
                let distance = manhattanDistanceBetween(gridCoordinate, coordinate2: coordinate)
//                print("\(coordinateName): \(distance)")
                if distance < minDistance {
                    minDistance = distance
                    gridWithClosestCoordinates[coordinate] = coordinateName.lowercased()
                } else if distance == minDistance {
                    gridWithClosestCoordinates[coordinate] = "."
                }
            }
        }
    }

//    printGrid(gridWithClosestCoordinates)
    return gridWithClosestCoordinates
}

func computeLargestAreaThatIsNotInfite(_ coordinates: [Coordinate]) -> Int {
    let grid = gridForCoordinates(coordinates)
    let gridWithClosestCoordinates = gridWithClosestCoordinatesForGrid(grid)

    var areaCount = [String: Int]()
    let coordinateNames = grid.map { return $1 }
    var coordinateNamesWithoutInfinteEdges = Set(coordinateNames)

    let maxX = getMaxXInGrid(gridWithClosestCoordinates)
    let maxY = getMaxYInGrid(gridWithClosestCoordinates)

    for (coordinate, coordinateName) in gridWithClosestCoordinates {
        if coordinate.x == 0 || coordinate.y == 0 || coordinate.x == maxX || coordinate.y == maxY {
            coordinateNamesWithoutInfinteEdges.remove(coordinateName.uppercased())
        }

        let currentArea = areaCount[coordinateName.lowercased()] ?? 0
        areaCount[coordinateName.lowercased()] = currentArea + 1
    }

    let nonInfiteAreas = areaCount.compactMap { (coordinateName, area) -> Int? in
        if coordinateNamesWithoutInfinteEdges.contains(coordinateName.uppercased()) == false {
            return nil
        }

        return area
    }

//    print(coordinateNamesWithoutInfinteEdges)
//    print(areaCount)
//    print(nonInfiteAreas)

    return nonInfiteAreas.max() ?? 0
}

func gridForCoordinates(_ coordinates: [Coordinate], withCombineDistanceLessThan distance: Int) -> Grid {
    let grid = gridForCoordinates(coordinates)
    var gridWithDistancesLessThanMaxDistance = Grid()

    let maxX = getMaxXInGrid(grid) + 1
    let maxY = getMaxYInGrid(grid) + 1

    for x in 0...maxX {
        for y in 0...maxY {
            let coordinate = Coordinate(x: x, y: y)
            var totalDistance = 0

            for (gridCoordinate, _) in grid {
                let distance = manhattanDistanceBetween(gridCoordinate, coordinate2: coordinate)
                totalDistance += distance
            }

            if totalDistance < distance {
                gridWithDistancesLessThanMaxDistance[coordinate] = "#"
            } else {
                gridWithDistancesLessThanMaxDistance[coordinate] = "."
            }
        }
    }

//    printGrid(gridWithDistancesLessThanMaxDistance)
    return gridWithDistancesLessThanMaxDistance
}

func areaForCoordinates(_ coordinates: [Coordinate], withDistanceLessThan distance: Int) -> Int {
    let grid = gridForCoordinates(coordinates, withCombineDistanceLessThan: distance)
    let filteredGrid = grid.filter { (coordinate, coordinateValue) -> Bool in
        return coordinateValue == "#"
    }

    return filteredGrid.count
}

func printGrid(_ grid: Grid) {
    let sortedKeys = grid.keys.sorted { (coordinate1, coordinate2) -> Bool in
        if coordinate1.y == coordinate2.y && coordinate1.x < coordinate2.x {
            return true
        } else if coordinate1.y < coordinate2.y {
            return true
        }

        return false
    }

    var currentRow = 0
    var string = ""

    for key in sortedKeys {
//        print("\(key): \(grid[key] ?? "")")
        let coordinateName = grid[key]
        let row = key.y

        if row != currentRow {
            currentRow = row
            string.append("\n")
        }

        string.append("\(coordinateName ?? "") ")
    }

//    print(string)
}
