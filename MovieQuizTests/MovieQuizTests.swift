//
//  MovieQuizTests.swift
//  MovieQuizTests
//
//  Created by Anna Fadieieva on 2023-02-12.
//

import XCTest

struct ArithmeticOperations {
    func addition(num1: Int, num2: Int, handler: @escaping (Int) -> Void)
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // Теперь наши функции возвращают результат асинхронно — через 1 секунду.
            handler(num1 + num2)
        }
    }
    
    func subtraction(num1: Int, num2: Int, handler: @escaping (Int) -> Void)
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            handler(num1 - num2)
        }
    }
    
    func multiplication(num1: Int, num2: Int, handler: @escaping (Int) -> Void)
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            handler(num1 * num2)
        }
    }
}

class MovieQuizTests:XCTestCase {
    func testAddition() throws {
        
        // Given дана структура для совершения арифметических операций и два числа, 1 и 2;
        let arithmeticOperations = ArithmeticOperations()
        let num1 = 1
        let num2 = 2
        
        // When когда мы получили результат сложения этих двух чисел,
        let expectation = expectation(description: "Addition function expectation")
        
        arithmeticOperations.addition(num1: num1, num2: num2) { result in
            
            //Then тогда сравниваем их с нашим ожиданием - числом 3
            XCTAssertEqual(result, 3)
            
        }
        
        waitForExpectations(timeout: 2)
    }
}

