//
//  main.swift
//  AdventOfCode
//
//  Created by Jasdeep Saini on 12/9/18.
//  Copyright © 2018 Outsite Networks. All rights reserved.
//

import Foundation

var regex: NSRegularExpression!

class Light: Equatable, CustomStringConvertible {
    let initialX: Int
    let initialY: Int
    let velocityX: Int
    let velocityY: Int

    init(initialX: Int, initialY: Int, velocityX: Int, velocityY: Int) {
        self.initialX = initialX
        self.initialY = initialY
        self.velocityX = velocityX
        self.velocityY = velocityY
    }

    static func == (lhs: Light, rhs: Light) -> Bool {
        return lhs.initialX == rhs.initialX &&
            lhs.initialY == rhs.initialY &&
            lhs.velocityX == rhs.velocityX &&
            lhs.velocityY == rhs.velocityY
    }

    var description: String {
        return "Light: \(initialX) \(initialY) \(velocityX) \(velocityY)"
    }
}

func setUpRegex() {
    let regexString = "^position=<([- ]*[0-9]+), ([- ]*[0-9]+)> velocity=<([- ]*[0-9]+), ([- ]*[0-9])+>"
    regex = try! NSRegularExpression(pattern: regexString, options: [])

}

func parseStrings(_ strings: [String]) -> [Light] {
    return strings.compactMap({ (string) -> Light? in
        let match = regex.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.count))

        guard let initialXRange = match?.range(at: 1),
            let initialYRange = match?.range(at: 2),
            let velocityXRange = match?.range(at: 3),
            let velocityYange = match?.range(at: 4),
            let initialX = Int((string as NSString).substring(with: initialXRange).trimmingCharacters(in: .whitespacesAndNewlines)),
            let initialY = Int((string as NSString).substring(with: initialYRange).trimmingCharacters(in: .whitespacesAndNewlines)),
            let velocityX = Int((string as NSString).substring(with: velocityXRange).trimmingCharacters(in: .whitespacesAndNewlines)),
            let velocityY = Int((string as NSString).substring(with: velocityYange).trimmingCharacters(in: .whitespacesAndNewlines)) else {
                return nil
        }

        return Light(initialX: initialX, initialY: initialY, velocityX: velocityX, velocityY: velocityY)
    })
}

func boundingAreaAtSecond(_ second: Int, for lights: [Light]) -> (result: [String: Light], area: Int, minX: Int, maxX: Int, minY: Int, maxY: Int) {
    var minX = Int.max
    var maxX = 0
    var minY = Int.max
    var maxY = 0

    let translatedLights = lights.reduce([String: Light]()) { (dictionary, light) -> [String: Light] in
        var newDictionary = dictionary

        let newX = light.initialX + (light.velocityX * second)
        let newY = light.initialY + (light.velocityY * second)

        if newX < minX {
            minX = newX
        }

        if newX > maxX {
            maxX = newX
        }

        if newY < minY {
            minY = newY
        }

        if newY > maxY {
            maxY = newY
        }

        let light = Light(initialX: newX,
                          initialY: newY,
                          velocityX: light.velocityX,
                          velocityY: light.velocityY)

        newDictionary["\(newX) \(newY)"] = light

        return newDictionary
    }

    let area = (maxX - minX) * (maxY - minY)
//    print("Area: \(area) minX: \(minX), maxX: \(maxX), minY: \(minY), maxY: \(maxY)")

    return (result: translatedLights, area: area, minX: minX, maxX: maxX, minY: minY, maxY: maxY)
//    print(translatedLights)
}

func displayLights(_ lights: [String: Light], minX: Int, maxX: Int, minY: Int, maxY: Int) {
    var string = ""
    for y in minY...maxY {
        string = string + "\n"
        for x in minX...maxX  {
            let key = "\(x) \(y)"

            if let _ = lights[key] {
                string = string + "#"
            } else {
                string = string + "."
            }
        }
    }

    print(string)
}
