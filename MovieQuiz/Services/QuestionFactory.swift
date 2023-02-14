import Foundation

class QuestionFactory: QuestionFactoryProtocol {
    private let moviesLoader: MoviesLoading
    private weak var delegate: QuestionFactoryDelegate?
    private var presenter: MovieQuizPresenter?

    init(moviesLoader: MoviesLoading, delegate: QuestionFactoryDelegate?) {
        self.moviesLoader = moviesLoader
        self.delegate = delegate
    }

    private var movies: [MostPopularMovie] = []
    
    func requestNextQuestion() {
        DispatchQueue.global().async { [weak self] in // запускаем код в другом потоке
            guard let self = self else { return }
            let index = (0..<self.movies.count).randomElement() ?? 0
            
            guard let movie = self.movies[safe: index] else { return } // выбираем произвольный элемент из массива, чтобы показать его.
            
            var imageData = Data() // по умолчанию у нас будут просто пустые данные
            do {
                imageData = try Data(contentsOf: movie.resizedImageURL)
            } catch {
                print("Failed to load image") // тут используем «трюк» с созданием данных из URL. Так как загрузка может пойти не по плану, очень важно обработать ошибку.
            }
            
            let rating = Float(movie.rating) ?? 0 // превращаем строку в число
            let arrayRating = Array(5...8)
            let questionText = Array(arrayLiteral:
                "Рейтинг этого фильма больше чем",
                "Рейтинг этого фильма меньше чем")
            
            let randomQuestion = questionText.randomElement()
            let randomRating = arrayRating.randomElement()
            guard let randomRating = randomRating,
                  let randomQuestion = randomQuestion
            else { return }
            let text = "\(randomQuestion) \(randomRating)?"
            let correctAnswer: Bool
            
            if randomQuestion == questionText[0] {
                correctAnswer = rating >
                Float(randomRating)
            } else {
                correctAnswer = rating <
                Float(randomRating)
            }
                    
            let question = QuizQuestion(image: imageData,
                                        text: text,
                                        correctAnswer: correctAnswer) // Создаём вопрос, определяем его корректность и создаём модель вопроса.
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.delegate?.didRecieveNextQuestion(question: question) // Теперь, когда загрузка и обработка данных завершена, пора вернуться в главный поток. Для этого используется строчка кода DispatchQueue.main.async { [weak self] in. И мы просто возвращаем наш вопрос через делегат.
            }
        }
    }

    func loadData() {
        moviesLoader.loadMovies { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let mostPopularMovies):
                    self.movies = mostPopularMovies.items // сохраняем фильм в нашу новую переменную
                    self.delegate?.didLoadDataFromServer() // сообщаем, что данные загрузились
                case .failure(let error):
                    self.delegate?.didFailToLoadData(with: error) // сообщаем об ошибке нашему MovieQuizViewController
                }
            }
        }
    }
}
