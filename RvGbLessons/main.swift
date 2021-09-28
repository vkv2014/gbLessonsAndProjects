//
//  main.swift
//  RvGbLessons
//
//  Created by Roman Vinokurov on 12.09.2021.
//

import Foundation

/*
 Урок 6. Продвинутое ООП
 1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
 2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
 3. Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
 */

// MARK: - FifiQueue

private struct FifoQueue<T>  {

    var items = [T]()

    mutating func addToQueue(item: T) {
        items.append(item)
    }

    mutating func removeFromQueue() {
        if items.count > 0 {
            items.removeFirst()
        }
    }

    mutating func removeFirstAndLast() {
        if items.count == 1 {
            items.removeFirst()
        } else if items.count > 1 {
            items.removeFirst()
            items.removeLast()
        }
    }

    subscript(index: Int) -> T? {
        return index > items.count - 1 || index < 0 ? nil : items[index]
    }
}

extension FifoQueue {
    func myFiler(complition: (T) -> Bool) -> [T] {
        var result: [T] = []
        for item in items where complition(item) {
            result.append(item)
        }
        return result
    }
}

// MARK: - Usage

private var queueExample = FifoQueue(items: ["aa", "ab", "ac"])
queueExample.addToQueue(item: "ba")
print(queueExample)

queueExample.removeFromQueue()
print(queueExample)

queueExample.removeFirstAndLast()
print(queueExample)

var indexValue = queueExample[10]
print(indexValue)

indexValue = queueExample[0]
print(indexValue)

// Filter out long names

let minLengthForLongNames = 3
queueExample.addToQueue(item: "bababa")
queueExample.addToQueue(item: "zazazabababa")
print(queueExample.myFiler { $0.count > minLengthForLongNames })
