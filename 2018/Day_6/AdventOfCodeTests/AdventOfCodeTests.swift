//
//  AdventOfCodeTests.swift
//  AdventOfCodeTests
//
//  Created by Jasdeep Saini on 12/9/18.
//  Copyright © 2018 Outsite Networks. All rights reserved.
//

import XCTest

class AdventOfCodeTests: XCTestCase {
    func testManhattanDistanceOfZero() {
        let coordinate1 = Coordinate(x: 10, y: 10)
        let coordinate2 = Coordinate(x: 10, y: 10)

        XCTAssertEqual(manhattanDistanceBetween(coordinate1, coordinate2: coordinate2), 0)
    }

    func testManhattanDistanceOfOne() {
        let coordinate1 = Coordinate(x: 9, y: 10)
        let coordinate2 = Coordinate(x: 10, y: 10)

        XCTAssertEqual(manhattanDistanceBetween(coordinate1, coordinate2: coordinate2), 1)
    }

    func testManhattanDistance() {
        let coordinate1 = Coordinate(x: 5, y: 22)
        let coordinate2 = Coordinate(x: 55, y: 102)

        XCTAssertEqual(manhattanDistanceBetween(coordinate1, coordinate2: coordinate2), 130)
    }

    func testCoordinateName() {
        XCTAssertEqual(getCoordinateName(at: 0), "A")
        XCTAssertEqual(getCoordinateName(at: 1), "B")
        XCTAssertEqual(getCoordinateName(at: 25), "Z")
        XCTAssertEqual(getCoordinateName(at: 26), "AA")
        XCTAssertEqual(getCoordinateName(at: 51), "ZZ")
        XCTAssertEqual(getCoordinateName(at: 52), "AAA")
        XCTAssertEqual(getCoordinateName(at: 77), "ZZZ")
    }

    func testExample1Grid() {
        let coordinates = example1Coordinates()

        let grid = gridForCoordinates(coordinates)
        XCTAssertEqual(grid[coordinates[0]], "A")
        XCTAssertEqual(grid[coordinates[1]], "B")
        XCTAssertEqual(grid[coordinates[2]], "C")
        XCTAssertEqual(grid[coordinates[3]], "D")
        XCTAssertEqual(grid[coordinates[4]], "E")
        XCTAssertEqual(grid[coordinates[5]], "F")
    }

    func testExample1MaxXInGrid() {
        let coordinates = example1Coordinates()

        let grid = gridForCoordinates(coordinates)

        XCTAssertEqual(getMaxXInGrid(grid), 8)
    }

    func testExample1MaxYInGrid() {
        let coordinates = example1Coordinates()

        let grid = gridForCoordinates(coordinates)

        XCTAssertEqual(getMaxYInGrid(grid), 9)
    }

    func testExample1CoordinatesWithClosesCoordinate() {
        let coordinates = example1Coordinates()

        let grid = gridForCoordinates(coordinates)
        let gridWithClosesCoordinates = gridWithClosestCoordinatesForGrid(grid)

        XCTAssertEqual(gridWithClosesCoordinates[Coordinate(x: 0, y: 0)], "a")
        XCTAssertEqual(gridWithClosesCoordinates[Coordinate(x: 0, y: 10)], "b")
        XCTAssertEqual(gridWithClosesCoordinates[Coordinate(x: 9, y: 0)], "c")
        XCTAssertEqual(gridWithClosesCoordinates[Coordinate(x: 9, y: 10)], "f")

        XCTAssertEqual(gridWithClosesCoordinates[Coordinate(x: 0, y: 4)], ".")
        XCTAssertEqual(gridWithClosesCoordinates[Coordinate(x: 3, y: 4)], "D")
    }

    func testExample1ComputeLargestAreaThatIsNotInfite() {
        let coordinates = example1Coordinates()

        XCTAssertEqual(computeLargestAreaThatIsNotInfite(coordinates), 17)
    }

    func testCoordinateForString() {
        let string = "310, 237"

        XCTAssertEqual(coordinateForString(string), Coordinate(x: 310, y: 237))
    }

    func testComputeLargestAreaThatIsNotInfiteForInput() {
        let coordinateStrings = readInputFileAsArrayOfStrings()
        let coordinates = coordinateStrings.map { (string) -> Coordinate in
            return coordinateForString(string)
        }

        XCTAssertEqual(computeLargestAreaThatIsNotInfite(coordinates), 3882)
    }

    func testExample1GridForCoordinatesWithDistanceLessThan() {
        let coordinates = example1Coordinates()
        let grid = gridForCoordinates(coordinates, withCombineDistanceLessThan: 32)

        XCTAssertEqual(grid[Coordinate(x: 0, y: 0)], ".")
        XCTAssertEqual(grid[Coordinate(x: 0, y: 10)], ".")
        XCTAssertEqual(grid[Coordinate(x: 9, y: 0)], ".")
        XCTAssertEqual(grid[Coordinate(x: 9, y: 10)], ".")

        XCTAssertEqual(grid[Coordinate(x: 4, y: 3)], "#")
        XCTAssertEqual(grid[Coordinate(x: 4, y: 4)], "#")
    }

    func testExample1AreaForCoordinatesWithDistanceLessThan() {
        let coordinates = example1Coordinates()
        XCTAssertEqual(areaForCoordinates(coordinates, withDistanceLessThan: 32), 16)
    }

    func testInputForAreaForCoordinatesWithDistanceLessThan() {
        let coordinateStrings = readInputFileAsArrayOfStrings()

        let coordinates = coordinateStrings.map { (string) -> Coordinate in
            return coordinateForString(string)
        }

        XCTAssertEqual(areaForCoordinates(coordinates, withDistanceLessThan: 10000), 43852)
    }

    func example1Coordinates() -> [Coordinate] {
        return [
            Coordinate(x: 1, y: 1),
            Coordinate(x: 1, y: 6),
            Coordinate(x: 8, y: 3),
            Coordinate(x: 3, y: 4),
            Coordinate(x: 5, y: 5),
            Coordinate(x: 8, y: 9)
        ]
    }
}
