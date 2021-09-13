//
//  main.swift
//  RvGbLessons
//
//  Created by Roman Vinokurov on 12.09.2021.
//

import Foundation

// MARK: УРОК 2. ЗАДАНИЕ 1.
// Написать функцию, которая определяет, четное число или нет.

func isEven(number: Int) -> Bool {
    return number % 2 == 0
}

// MARK: УРОК 2. ЗАДАНИЕ 2.
// Написать функцию, которая определяет, делится ли число без остатка на 3.

func isDevisibleByThree(number: Int) -> Bool {
    return number % 3 == 0
}

// MARK: УРОК 2. ЗАДАНИЕ 3.
// Создать возрастающий массив из 100 чисел.

var array = [0]
for index in 1...99 {
    array += [array[index-1] + 1]
}

// MARK: УРОК 2. ЗАДАНИЕ 4.
// Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

let arrayFiltered = array.filter { !isEven(number: $0) && isDevisibleByThree(number: $0) }

// MARK: УРОК 2. ЗАДАНИЕ 5.
// Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.
let fibonacciArray = createFibonacciArray(length: 50)

func createFibonacciArray(length: Int) -> [Int] {
    var array = [0, 1]
    if length <= 1 {
        print("Length should be 2 at least. Assuming it is 2")
    }
    else {
        while array.count < length {
            array.append(array[array.count - 2] + array[array.count - 1])
        }
    }
    return array
}

// MARK: УРОК 2. ЗАДАНИЕ 6.
/* Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется
 простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n,
 следуя методу Эратосфена, нужно выполнить следующие шаги:
 a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
 b. Пусть переменная p изначально равна двум — первому простому числу.
 c. Зачеркнуть в списке числа от 2 + p до n, считая шагом p..
 d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
 e. Повторять шаги c и d, пока возможно.
 */
let n = 100
var primeArray: [Int] = []
var intArray = populateIntArray(length: n)
while(intArray.count > 0) {
    primeArray.append(intArray[0])
    intArray = intArray.filter { !isDevisibleByN(number: $0, n: intArray[0]) }
}

func populateIntArray(length: Int) -> [Int] {
    var tempArray: [Int] = []
    for indexOfIntArray in 2...length {
        tempArray.append(indexOfIntArray)
    }
    return tempArray
}

func isDevisibleByN(number: Int, n: Int) -> Bool {
    return number % n == 0
}
