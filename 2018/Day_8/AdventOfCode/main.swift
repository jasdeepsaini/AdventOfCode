//
//  main.swift
//  AdventOfCode
//
//  Created by Jasdeep Saini on 12/9/18.
//  Copyright © 2018 Outsite Networks. All rights reserved.
//

import Foundation

class Node: CustomStringConvertible {
    var nodeNumber: String = UUID().uuidString
    var numberOfChildNodes: Int = 0
    var numberOfMetaDataEntries: Int = 0
    var childNodes = [Node]()
    var metaDataEntries = [Int]()
    var value: Int = 0

    var description: String {
        return "\(nodeNumber) \(numberOfChildNodes) \(numberOfMetaDataEntries)"
        //" \(childNodes) \(metaDataEntries)"
    }
}

func getNumbersFromString(_ string: String) -> [Int] {
    return string.components(separatedBy: " ").compactMap { return Int($0) }
}

func parseNodesFromNumbers(_ numbers: ArraySlice<Int>) -> (remainingNumbers: ArraySlice<Int>, node: Node) {
    let node = Node()
    var remainingNumbers = numbers
    node.numberOfChildNodes = remainingNumbers.removeFirst()
    node.numberOfMetaDataEntries = remainingNumbers.removeFirst()

    for _ in 0..<node.numberOfChildNodes {
        let result = parseNodesFromNumbers(remainingNumbers)
        node.childNodes.append(result.node)
        remainingNumbers = result.remainingNumbers
    }

    for _ in 0..<node.numberOfMetaDataEntries {
        let value = remainingNumbers.removeFirst()
        node.metaDataEntries.append(value)
    }

    return (remainingNumbers: remainingNumbers, node: node)
}

func computeMetaDataEntryTotalForNode(_ node: Node, currentTotal: Int) -> Int {
    var newTotal = node.metaDataEntries.reduce(currentTotal) { (total, metaData) -> Int in
        return total + metaData
    }

    for childNode in node.childNodes {
        newTotal = computeMetaDataEntryTotalForNode(childNode, currentTotal: newTotal)
    }

    return newTotal
}

func updateValueForNode(_ node: Node) {
    if node.childNodes.isEmpty {
        node.value = node.metaDataEntries.reduce(0, { (total, metaData) -> Int in
            return total + metaData
        })
    } else {
        var childValues = [Int]()

        for child in node.childNodes {
            updateValueForNode(child)
            childValues.append(child.value)
        }

        var nodeValue = 0

        for entry in node.metaDataEntries {
            let index = entry - 1

            if index >= 0 && index < node.childNodes.count {
                let childNode = node.childNodes[index]
                nodeValue = nodeValue + childNode.value
            }
        }

        node.value = nodeValue
    }
}
