//
//  main.swift
//  AdventOfCode
//
//  Created by Jasdeep Saini on 12/9/18.
//  Copyright © 2018 Outsite Networks. All rights reserved.
//

import Foundation

typealias ParsedNode = (nodeName: String, edge: String)
typealias NodeDictionary = [String: Node]
typealias Job = (nodeName: String, startSecond: Int)

class Node: CustomStringConvertible, Hashable, Equatable {
    let name: String
    var edges = Set<String>()

    init(name: String) {
        self.name = name
    }

    var description: String {
        return "Name: \(name) Edges: \(edges)"
    }

    var hashValue: Int {
        return name.hashValue ^ edges.hashValue
    }

    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.name == rhs.name && lhs.edges == rhs.edges
    }
}

var regex = NSRegularExpression()

func valueForLetter(_ letter: String) -> Int {
    return Int((UnicodeScalar(letter)?.value ?? 0)) - 64
}

func setUpRegex() {
    let regexString = "^Step (.)+ must be finished before step (.)+ can begin.$"
    regex = try! NSRegularExpression(pattern: regexString, options: [])
}

func parseDependencyString(_ string: String) ->  ParsedNode? {
    guard let match = regex.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.count)) else {
        return nil;
    }

    let edgeRange = match.range(at: 1)
    let nodeNameRange = match.range(at: 2)

    let edge = (string as NSString).substring(with: edgeRange)
    let nodeName =  (string as NSString).substring(with: nodeNameRange)

    return (nodeName: nodeName, edge: edge)
}

func nodesForDependencyStrings(_ strings: [String]) -> NodeDictionary {
    var nodeDictionary = NodeDictionary()

    for string in strings {
        guard let parsedNode = parseDependencyString(string) else { continue }

        if nodeDictionary[parsedNode.nodeName] == nil {
            nodeDictionary[parsedNode.nodeName] = Node(name: parsedNode.nodeName)
        }

        if nodeDictionary[parsedNode.edge] == nil {
            nodeDictionary[parsedNode.edge] = Node(name: parsedNode.edge)
        }

        nodeDictionary[parsedNode.nodeName]?.edges.insert(parsedNode.edge)
    }

    return nodeDictionary
}

func resolveNodeDictionary(_ nodeDictionary: NodeDictionary) -> String {
    var remainingDependencies = nodeDictionary
    var removalString = ""

    while remainingDependencies.count > 0 {
        let nodesWithoutDependencies = remainingDependencies.filter { (nodeName, node) -> Bool in
            return node.edges.count == 0
        }.sorted(by: { node1, node2 -> Bool in
            return node1.key < node2.key
        })

//        print("Before Removal:")
//        printNodeDictionary(remainingDependencies)

        if let resolvedDependency = nodesWithoutDependencies.first {
            print("Removing: \(resolvedDependency.key)")
            removalString.append(resolvedDependency.key)

            remainingDependencies.removeValue(forKey: resolvedDependency.key)

            for dependency in remainingDependencies {
                dependency.value.edges.remove(resolvedDependency.key)
            }

//            print("After Removal:")
//            printNodeDictionary(remainingDependencies)
        }
    }

    return removalString
}

func resolveNodeDictionaryWithHelpers(_ nodeDictionary: NodeDictionary, numberOfHelpers: Int, additionalSecondsPerStep: Int) -> Int {
    var remainingDependencies = nodeDictionary
    var removalString = ""
    let numberOfWorkers = numberOfHelpers + 1

    var jobs = [Job]()

    var currentSecond = 0
    var done = false

    while done == false {
        print("Second Start: \(currentSecond): \(jobs)")

        var newJobsList = [Job]()

        for job in jobs {
            let jobDuration = additionalSecondsPerStep + valueForLetter(job.nodeName)
            let finishSecond = job.startSecond + jobDuration

            if currentSecond != finishSecond {
                newJobsList.append(job)
            } else {
                remainingDependencies.removeValue(forKey: job.nodeName)
                removalString.append(job.nodeName)

                for dependency in remainingDependencies {
                    dependency.value.edges.remove(job.nodeName)
                }
            }
        }

        jobs = newJobsList

        if jobs.count == numberOfWorkers {
            print("Second Final: \(currentSecond): \(jobs)")
            currentSecond = currentSecond + 1

            continue
        }

        var nodesWithoutDependencies = remainingDependencies.filter { (nodeName, node) -> Bool in
            return node.edges.count == 0 && jobs.first(where: { $0.nodeName == nodeName }) == nil
        }
        .sorted(by: { node1, node2 -> Bool in
            return node1.key < node2.key
        })

        while jobs.count < numberOfWorkers && nodesWithoutDependencies.count > 0 {
            let node = nodesWithoutDependencies.removeFirst()
            jobs.append(Job(nodeName: node.key, startSecond: currentSecond))
        }

        print("Second Final: \(currentSecond): \(jobs)")

        if remainingDependencies.count == 0 && jobs.count == 0 {
            done = true
        }

        currentSecond = currentSecond + 1
    }

    return currentSecond - 1
}

func printNodeDictionary(_ nodeDictionary: NodeDictionary) {
    for key in nodeDictionary.keys.sorted(by: { $0 < $1 }) {
        print("\(nodeDictionary[key] ?? Node(name: ""))")
    }
}
