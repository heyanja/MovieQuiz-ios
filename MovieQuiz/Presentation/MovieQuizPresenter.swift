//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by Anna Fadieieva on 2023-02-13.
//

import UIKit

final class MovieQuizPresenter {
    func convert(model: QuizQuestion) -> QuizStepViewModel {
        return QuizStepViewModel(
            image: UIImage(data: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
    }
}
