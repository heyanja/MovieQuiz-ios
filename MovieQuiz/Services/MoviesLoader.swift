// сервис для загрузки фильмов. Он будет загружать фильмы, используя NetworkClient, и преобразовывать их в модель данных MostPopularMovies.
import Foundation

protocol MoviesLoading { //создадим в этом же файле протокол для загрузчика фильмов
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void)
}

struct MoviesLoader: MoviesLoading { // загрузчик, который будет реализовывать этот протокол
    // MARK: - NetworkClient
    private let networkClient = NetworkClient() // Чтобы создавать запросы к API IMDb, нужен NetworkClient.
    
    // MARK: - URL
    private var mostPopularMoviesUrl: URL { // Также нам понадобится URL, на который мы будем делать запрос
        // Если мы не смогли преобразовать строку в URL, то приложение упадёт с ошибкой
        guard let url = URL(string: "https://imdb-api.com/en/API/Top250Movies/k_l54608v1") else {
            preconditionFailure("Unable to construct mostPopularMoviesUrl")
        }
        return url
    }
    
    //реализовать загрузку фильмов в методе loadMovies
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void) {
        // Используйте переменные networkClient и mostPopularMoviesUrl.
        networkClient.fetch(url: mostPopularMoviesUrl) { result in
            switch result {
                // В замыкании обработайте ошибочное состояние и передайте его дальше в handler.
            case .success(let data):
                do { // Преобразуйте данные в MostPopularMovies, используя JSONDecoder.
                    let mostPopularMovies = try JSONDecoder().decode(MostPopularMovies.self, from: data)
                    handler(.success(mostPopularMovies)) // Верните их, используя handler.
                } catch {
                    handler(.failure(error))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}

