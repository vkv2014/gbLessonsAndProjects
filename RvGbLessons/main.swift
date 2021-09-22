//
//  main.swift
//  RvGbLessons
//
//  Created by Roman Vinokurov on 12.09.2021.
//

import Foundation

enum Colors {
    case black
    case white
    case red
}


class Car {
    let model: String
    var color: Colors
    let prodYear: Int
    let fuelTankVolume: Int


    init (model: String,
          prodYear: Int,
          color: Colors,
          fuelTankVolume: Int) {
        self.model = model
        self.prodYear = prodYear
        self.color = color
        self.fuelTankVolume = fuelTankVolume
    }

    func printCar() {
        print("""
            Model: \(model)
            Color: \(color)
            Year: \(prodYear)
            Tank Volume: \(fuelTankVolume)
            """)
    }
    func loadCar(_ loadCargoAmount: Int) { }
}

final class TrunkCar: Car {
    enum LoadCargo {
        case Load1Container
        case load5Containers
    }

    let maxContainers: Int
    var currentContainersAmount: Int

    init(model: String,
         prodYear: Int,
         color: Colors,
         fuelTankVolume: Int,
         maxContainers: Int) {

        self.maxContainers = maxContainers
        self.currentContainersAmount = 0
        super.init(model: model,
                   prodYear: prodYear,
                   color: color,
                   fuelTankVolume: fuelTankVolume)
        }

    override func loadCar(_ loadCargoAmount: Int) {
        currentContainersAmount += loadCargoAmount
        print("Load: \(currentContainersAmount) containers")
    }

    override func printCar() {
        super.printCar()
        print("Максимальное количество контейнеров:", maxContainers)
    }
}

final class SportCar: Car {
    enum GetPassengers{
        case get1Passenger
        case getPassengersMaxAmount
    }

    let passengersCapacity: Int
    var currentPassengersAmount: Int

    init(model: String,
         prodYear: Int,
         color: Colors,
         fuelTankVolume: Int,
         currentPassengersAmount: Int,
         passengersCapacity: Int) {
        self.currentPassengersAmount = currentPassengersAmount
        self.passengersCapacity = passengersCapacity
        super.init(model: model,
                   prodYear: prodYear,
                   color: color,
                   fuelTankVolume: fuelTankVolume)
        }
    override func loadCar(_ loadCargoAmount: Int) {
        let action = loadCargoAmount >= 0 ? "посадить" : "высадить"
        print("Пробуем \(action) \(abs(loadCargoAmount)) человек")
        let newPassengersAmount = currentPassengersAmount + loadCargoAmount
        if newPassengersAmount >= 0 && newPassengersAmount <= passengersCapacity {
            currentPassengersAmount = newPassengersAmount
        } else {
            currentPassengersAmount = newPassengersAmount < 0 ? 0 : passengersCapacity
        }
    }

    override func printCar() {
        super.printCar()
        print("Количество людей в машине в данный момент:", currentPassengersAmount)
        print("Максимальное количество людей в машине:", passengersCapacity)
    }
    func loadCarByGroupOfPeople(_ loadCargoAmount: GetPassengers) {
        let newPassengers = loadCargoAmount == GetPassengers.get1Passenger ? 1 : passengersCapacity
        print("Пробуем посадить \(abs(newPassengers)) человек")
        let newPassengersAmount = currentPassengersAmount + newPassengers
        if newPassengersAmount >= 0 && newPassengersAmount <= passengersCapacity {
            currentPassengersAmount = newPassengersAmount
        } else {
            currentPassengersAmount = newPassengersAmount < 0 ? 0 : passengersCapacity
        }
    }

}

let sportCar1: SportCar = SportCar(model: "Ferrari",
                                   prodYear: 2021,
                                   color: .red,
                                   fuelTankVolume: 80,
                                   currentPassengersAmount: 0,
                                   passengersCapacity: 2)

let trunkCar1: TrunkCar = TrunkCar(model: "MAN",
                                   prodYear: 2011,
                                   color: .white,
                                   fuelTankVolume: 800,
                                   maxContainers: 5)

sportCar1.printCar()
sportCar1.loadCar(5) // Пробуем посадить 5 человек
sportCar1.printCar()
sportCar1.loadCar(-10) // Пробуем высадить 10 человек
sportCar1.printCar()

trunkCar1.printCar()
