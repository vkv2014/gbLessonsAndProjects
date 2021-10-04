//
//  main.swift
//  RvGbLessons
//
//  Created by Roman Vinokurov on 12.09.2021.
//

import Foundation

// MARK: - VendingMachineError
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds
    case coinsNeeded(coinsNeeded: Int)
    case outOfStock
}

// MARK: - Item
struct Item {
    var price: Int
    var count: Int
}

// MARK: - VendingMachine
class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0

    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }

        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }

        guard item.price <= coinsDeposited else {
            throw VendingMachineError.coinsNeeded(coinsNeeded: item.price - coinsDeposited)
        }

        coinsDeposited -= item.price

        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem

        print("Dispensing \(name). Remaining coins: \(coinsDeposited)")
    }

    func depositCoins(deposit coins: Int) {
        coinsDeposited += coins
        print("Coins deposited: \(coins). Remaining coins: \(coinsDeposited)")
    }
}

// MARK: - Usage
var myVendingMachine = VendingMachine()
myVendingMachine.depositCoins(deposit: 10)

do {
    try myVendingMachine.vend(itemNamed: "Candy Bar")
}
catch VendingMachineError.insufficientFunds{
    print("Мало денег!")
}
