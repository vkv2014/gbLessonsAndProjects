//
//  main.swift
//  RvGbLessons
//
//  Created by Roman Vinokurov on 12.09.2021.
//

import Foundation

enum EngineState: String {
    case on = "Started"
    case off = "Stopped"
}

enum WindowsState: String {
    case open = "Open"
    case closed = "Closed"
}

struct SportCar {
    let mark: String
    let year: Int
    let totalTrunckVolume: Int
    var filledTrunkVolume: Int
    var engineState: EngineState

    var windowsState: WindowsState{
        willSet {
            newValue == .open ? print("Opening windows") : print("Closing windows")
        }
        didSet {
            oldValue == .open ? print("Windows closed") : print("Windows opened")
        }
    }

    mutating func startEngine() {
        self.engineState = .on
        print("Engine \(engineState.rawValue)")
    }

    mutating func stopEngine() {
        self.engineState = .off
        print("Engine \(engineState.rawValue)")
    }

    mutating func loadLuggage(load volume: Int) {
        if filledTrunkVolume + volume < 0 {
            filledTrunkVolume = 0
            print("Trunck is empty")
        }
        else if filledTrunkVolume + volume > totalTrunckVolume {
            filledTrunkVolume = totalTrunckVolume
            print("Trunck is full")
        }
        else {
            filledTrunkVolume += volume
            print("Filled trunk volume: \(filledTrunkVolume)")
        }
    }

    func printCar() {
        print("""
            mark: \(mark)
            year: \(year)
            totalTrunckVolume: \(totalTrunckVolume)
            filledTrunkVolume: \(filledTrunkVolume)
            """)
    }
}
struct TruckCar {
    let model: String
    let year: Int
    let totalTrunckVolume: Int
    let filledTrunkVolume: Int
    let isStarted: Bool
    let isWindowsOpen: Bool
}

var truck = TruckCar(model: "Volvo", year: 2000, totalTrunckVolume: 2000, filledTrunkVolume: 0, isStarted: false,
                     isWindowsOpen: false)

var myCar = SportCar(mark: "Lada", year: 1990, totalTrunckVolume: 200, filledTrunkVolume: 0, engineState: .off,
                     windowsState: .closed)

myCar.printCar()
print(myCar)
print(truck)

myCar.loadLuggage(load: 50)
print(myCar)
myCar.loadLuggage(load: -20)
print(myCar)
myCar.loadLuggage(load: 200000)
print(myCar)
myCar.loadLuggage(load: -1200000)
print(myCar)

myCar.startEngine()
print("My car engine state: \(myCar.engineState.rawValue)")

// Нужно было больше кода, но делал в остром цейтноте, буквально на бегу :)
