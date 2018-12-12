//
//  main.swift
//  AdventOfCode
//
//  Created by Jasdeep Saini on 12/9/18.
//  Copyright © 2018 Outsite Networks. All rights reserved.
//

import Foundation

class Node: CustomStringConvertible {
    let value: Int
    var previousNode: Node?
    var nextNode: Node?

    init(value: Int) {
        self.value = value
    }

    var description: String {
        return "Value: \(value) Next: \(nextNode?.value ?? -1) Previous: \(previousNode?.value ?? -1)"
    }
}

// TODO: Figure out the best way to avoid force casts
func highScore(for playerCount: Int, finalMarbleValue: Int) -> Int {
    var scores = [Int: Int]()

    let headNode = Node(value: 0)
    let nextNode = Node(value: 1)

    headNode.previousNode = nextNode
    headNode.nextNode = nextNode

    nextNode.previousNode = headNode
    nextNode.nextNode = headNode

    var currentNode = nextNode

    for index in 2...finalMarbleValue {
        let currentPlayer = (index % playerCount)

        if index % 23 == 0 {
            var newScore = index

            var nodeToBeRemoved = currentNode

            for _ in 0..<7 {
                nodeToBeRemoved = nodeToBeRemoved.previousNode!
            }

            newScore = newScore + nodeToBeRemoved.value

            currentNode = nodeToBeRemoved.nextNode!

            nodeToBeRemoved.previousNode?.nextNode = currentNode
            nodeToBeRemoved.nextNode?.previousNode = nodeToBeRemoved.previousNode

            let currentScore = scores[currentPlayer] ?? 0
            scores[currentPlayer] = currentScore + newScore

            continue
        }

        let nextNode = currentNode.nextNode
        let newNode = Node(value: index)

        newNode.previousNode = nextNode
        newNode.nextNode = nextNode?.nextNode

        nextNode?.nextNode?.previousNode = newNode
        nextNode?.nextNode = newNode

        currentNode = newNode
    }

    //    printNodesForHead(headNode)

    let highScore = scores.values.max() ?? 0
    return highScore
}

func printNodesForHead(_ node: Node) {
    var currentNode: Node? = node

    while currentNode?.nextNode?.value != node.value {
        print("\(String(describing: currentNode))")
        currentNode = currentNode?.nextNode
    }

    print("\(String(describing: currentNode))")
}
//    var previousMarble = 1
//    var currentPlayer = 1
//    var marbles = [0, 1]
//    var scores = [Int: Int]()
//
//    for index in 2...finalMarbleValue {
//        if index % 23 == 0 {
//            var newScore = index
//
//            let previousMarbleIndex = (marbles.firstIndex(of: previousMarble) ?? 0)
//
//            let removedMarbleIndex = previousMarbleIndex - 7
//            let nextCurrentMarbleIndex = removedMarbleIndex + 1
//
//            if nextCurrentMarbleIndex >= 0 {
//                previousMarble = marbles[nextCurrentMarbleIndex]
//            } else {
//                previousMarble = marbles[marbles.count + nextCurrentMarbleIndex]
//            }
//
//            if removedMarbleIndex >= 0 {
//                let removedMarbleValue = marbles.remove(at: removedMarbleIndex)
//                newScore = newScore + removedMarbleValue
//            } else {
//                let removedMarbleValue = marbles.remove(at: marbles.count + removedMarbleIndex)
//                newScore = newScore + removedMarbleValue
//            }
//
//            let currentScore = scores[currentPlayer] ?? 0
//            scores[currentPlayer] = currentScore + newScore
//
//            currentPlayer = (currentPlayer + 1) % playerCount
//
//            continue
//        }
//
//        let nextMarbleIndex = (marbles.firstIndex(of: previousMarble) ?? 0) + 2
//
//        if nextMarbleIndex < marbles.count {
//            marbles.insert(index, at: nextMarbleIndex)
//        } else if nextMarbleIndex == marbles.count {
//            marbles.append(index)
//        } else {
//            marbles.insert(index, at: 1)
//        }
//
//        previousMarble = index
//        currentPlayer = (currentPlayer + 1) % playerCount
//    }
//
//    let highScore = scores.values.max() ?? 0
//
//    return highScore
//}

