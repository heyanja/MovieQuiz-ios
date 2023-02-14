import XCTest // не забывайте импортировать фреймворк для тестирования
@testable import MovieQuiz // импортируем наше приложение для тестирования

class ArrayTests: XCTestCase {
    func testGetValueInRange() { // тест на успешное взятие элемента по индексу
        // Given дано — массив (например, массив чисел) из 5 элементов,
        let array = [1, 1, 2, 3, 5]
        
        // When когда — мы берём элемент по индексу 2, используя наш сабскрипт,
        let value = array[safe: 2]
        
        // Then тогда — этот элемент существует и равен третьему элементу из массива (потому что отсчёт индексов в массиве начинается с 0).
        XCTAssertNotNil(value)
        XCTAssertEqual(value, 2)
    }
    
    func testGetValueOutofRange() throws { // тест на взятие элемента по неправильному индексу
        // Given
        let array = [1, 1, 2, 3 , 5]
        
        // When
        let value = array[safe: 20]
        
        // Then
        XCTAssertNil(value)
    }
}

//extension Array {
//    subscript(safe index: Index) -> Element? {
//        indices ~= index ? self[index] : nil
//    }
//}
