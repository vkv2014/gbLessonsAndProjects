//
//  main.swift
//  RvGbLessons
//
//  Created by Roman Vinokurov on 12.09.2021.
//

import Foundation

// Урок 5. ООП: требование к классам, протоколы, расширения, полиморфизм, композиция
// MARK: - Common enums

enum Fuel: String {
    case diesel
    case standard92
    case euro95
    case euro98
}

enum WindowsActions: String {
    case open
    case close
}

enum CarLock: String {
    case open
    case close
}

enum EngineAction {
    case start
    case stop
}

// MARK: - Car area

protocol Car {
    var mark: String { get }
    var model: String { get }
    var fuel: Fuel { get }
    var year: Int { get }

    var isCarClosed: Bool { get set }
    var isWindowsClosed: Bool { get set }
    var isEngineStarted: Bool { get set }

    func refuel (liters: Int)
}

extension Car {
    mutating func ActWindows (action: WindowsActions){
        switch action {
        case .open:
            isWindowsClosed = false
            print("Windows open")
        case .close:
            isWindowsClosed = true
            print("Windows closed")
        }
    }

    mutating func ActEngine (action: EngineAction){
        isEngineStarted = action == .start
        print((isEngineStarted ? "starting" : "stopping"), "engine")
    }

    func refuel (liters: Int) {
        print("Залито \(liters) топлива (\(fuel.rawValue))")
    }

    func printCarDetails() {
        print("""
            ____________________________
            mark&model: \(mark) \(model)
            fuel: \(fuel)
            year: \(year)
            ____________________________
            """)
    }

    func printCarState() {
        print("Doors " + (isCarClosed ? "closed" : "open"))
        print("Windows " + (isWindowsClosed ? "closed" : "open"))
        print("Engine " + (isEngineStarted ? "started" : "stopped"))
    }
}

// MARK: - TrunkCar area

final class TrunkCar: Car {
    let mark: String
    let model: String
    let fuel: Fuel
    let year: Int
    let trunkVolume: Int

    var isCarClosed: Bool
    var isWindowsClosed: Bool
    var isEngineStarted: Bool

    var litersInTankNow: Int {
        willSet {
            print("Будет произведена погрузка/разгурзка до \(litersInTankNow) литров")
        }
        didSet {
            print("Новая заполненность цистерны - \(litersInTankNow) литров")
        }
    }

    init(mark: String,
         model: String,
         fuel: Fuel,
         year: Int,
         trunkVolume: Int)
    {
        self.mark = mark
        self.model = model
        self.fuel = fuel
        self.year = year
        self.isCarClosed = true
        self.isWindowsClosed = true
        self.isEngineStarted = false
        self.trunkVolume = trunkVolume
        self.litersInTankNow = 0
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "Автоцистерна вместимостью \(trunkVolume) литров"
    }
}

// MARK: - SportCar

final class SportCar: Car {
    var mark: String
    var model: String
    var fuel: Fuel
    var year: Int
    var isCarClosed: Bool
    var isWindowsClosed: Bool
    var isEngineStarted: Bool
    let passengersMax: Int

    init(mark: String,
         model: String,
         fuel: Fuel,
         year: Int,
         passengersMax: Int)
    {
        self.mark = mark
        self.model = model
        self.fuel = fuel
        self.year = year
        self.isCarClosed = true
        self.isWindowsClosed = true
        self.isEngineStarted = false
        self.passengersMax = passengersMax
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return "Спортивный автомобиль вместимостью \(passengersMax) пассажиров"
    }
}

// MARK: - Practical usage

var myNewCar: SportCar = SportCar(mark: "BMW", model: "X6 5.0d", fuel: .diesel, year: 2021, passengersMax: 5)
var myFathersCar: SportCar = SportCar(mark: "Ford", model: "Focus", fuel: .euro95, year: 2003, passengersMax: 5)
var myWorkCar: TrunkCar = TrunkCar(mark: "MAN", model: "M500", fuel: .diesel, year: 2018, trunkVolume: 5000)
var myFutherWorkCar: TrunkCar = TrunkCar(mark: "MAN", model: "M600", fuel: .diesel, year: 2022, trunkVolume: 9000)

myNewCar.printCarDetails()
print(myNewCar.description)
myNewCar.printCarState()
print("---")

myNewCar.refuel(liters: 45)
myNewCar.ActEngine(action: .start)
myNewCar.printCarState()
print("---")

myFathersCar.printCarState()
myFathersCar.ActEngine(action: .start)
myFathersCar.ActWindows(action: .open)
myFathersCar.refuel(liters: 15)
myFathersCar.printCarState()
print("---")

print("Моя нынещняя рабочая машина: ")
myWorkCar.printCarDetails()
print("Моя будущая рабочая машина: ")
myFutherWorkCar.printCarDetails()
