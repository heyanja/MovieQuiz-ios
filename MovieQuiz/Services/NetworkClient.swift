// Задача NetworkClient — загружать данные

import Foundation
/// Отвечает за загрузку данных по URL
struct NetworkClient {
    
    private enum NetworkError: Error {
        case codeError
    }
    
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url) // создаём запрос из url
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in // начинаем писать обработку ответа. Как уже было сказано, в ответе все аргументы data, response, error — опциональные: чтобы понять, какой ответ нам пришёл, надо их распаковать.
            // Проверяем, пришла ли ошибка
            if let error = error {
                handler(.failure(error))
                return // Здесь мы распаковываем ошибку с помощью оператора if. Если ошибка оказалась не пустой, значит, что-то пошло не так и ответ от сервера не получен. Тогда мы считаем, что результат у нас не успешный и возвращаем .failure(error) — то же самое, что и Result.failure(error) — как результат нашей функции запроса.
            }
            // Проверяем, что нам пришёл успешный код ответа
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode >= 300 { // Код ответа 200 — это успешный ответ; любой код меньше 300 — тоже успешный ответ, только с дополнительными комментариями
                handler(.failure(NetworkError.codeError))
                return  // дальше продолжать не имеет смысла, так что заканчиваем выполнение этого кода
            }
            
            // Возвращаем данные
            guard let data = data else { return }
            handler(.success(data))
        }
        
        task.resume()
    }
}
