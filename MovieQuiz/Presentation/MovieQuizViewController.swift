//import UIKit
//
//final class MovieQuizViewController: UIViewController, MovieQuizViewControllerProtocol {
//
//    // MARK: - Properties
//
//    private var alertPresenter: AlertPresenter!
//    private var presenter: MovieQuizPresenter!
//    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
//
//
//    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet private weak var textLabel: UILabel!
//    @IBOutlet private weak var counterLabel: UILabel!
//    @IBOutlet private weak var textOfQuestion: UILabel!
//    @IBOutlet private weak var questionLabelText: UILabel!
//    @IBOutlet private weak var indexQuestionText: UILabel!
//    @IBOutlet private weak var noButton: UIButton!
//    @IBOutlet private weak var yesButton: UIButton!
//    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
//
//
//    // MARK: Lifecycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        alertPresenter = AlertPresenter(viewController: self)
//        presenter = MovieQuizPresenter(viewController: self)
//
//        showLoadingIndicator()
//    }
//
//
//    // MARK: - Actions
//
//    @IBAction private func yesButtonClicked(_ sender: UIButton) {
//        presenter.yesButtonClicked()
//        blockButton()
//    }
//    @IBAction private func noButtonClicked(_ sender: UIButton) {
//        presenter.noButtonClicked()
//        blockButton()
//    }
//
//    func unlockButton() {
//        noButton.isEnabled = true
//        yesButton.isEnabled = true
//    }
//
//    func blockButton() {
//        noButton.isEnabled = false
//        yesButton.isEnabled = false
//    }
//
//    func show(quiz step: QuizStepViewModel) {
//        UIView.transition(with: imageView,
//                          duration: 0.3,
//                          options: .transitionCrossDissolve,
//                          animations: { self.imageView.image = step.image},
//                          completion: nil)
//        imageView.image = step.image
//        imageView.layer.cornerRadius = 20
//        imageView.animationDuration = 1
//        textLabel.text = step.question
//        counterLabel.text = step.questionNumber
//    }
//
//    func showLoadingIndicator() {
//        activityIndicator.isHidden = false // говорим, что индикатор загрузки не скрыт
//        activityIndicator.startAnimating() // включаем анимацию
//    }
//    func hideLoadingIndicator() {
//        activityIndicator.isHidden = true
//        activityIndicator.stopAnimating()
//    }
//
//    func showNetworkError(message: String) {
//        hideLoadingIndicator()
//
//        let alert = AlertModel(title: "Ошибка", message: message, buttonText: "Попробовать еще раз") { [weak self] in
//            guard let self = self else { return }
//            self.presenter.restartGame()
//        }
//        alertPresenter?.showQuizResult(model: alert)
//    }
//
//
//    func highlightImageBorder(isCorrect: Bool) {
//        imageView.layer.masksToBounds = true
//        imageView.layer.borderWidth = 8
//        imageView.layer.cornerRadius = 20
//        if isCorrect {
//            imageView.layer.borderColor = UIColor.ypGreen.cgColor
//        } else {
//            imageView.layer.borderColor = UIColor.ypRed.cgColor
//        }
//    }
//}
//
//
import UIKit

final class MovieQuizViewController: UIViewController, MovieQuizViewControllerProtocol {
   
    private var presenter: MovieQuizPresenter!
    private var alertPresenter: AlertPresenter!
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var textOfQuestion: UILabel!
    @IBOutlet private weak var questionLabelText: UILabel!
    @IBOutlet private weak var indexQuestionText: UILabel!
    @IBOutlet private weak var noButton: UIButton!
    @IBOutlet private weak var yesButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertPresenter = AlertPresenter(viewController: self)
        presenter = MovieQuizPresenter(viewController: self)
        showLoadingIndicator()
    }
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        presenter.noButtonClicked()
        blockButton()
    }
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        presenter.yesButtonClicked()
        blockButton()
    }
    
    func unlockButton() {
        noButton.isEnabled = true
        yesButton.isEnabled = true
    }
    
    func blockButton() {
        noButton.isEnabled = false
        yesButton.isEnabled = false
    }
    
    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func showNetworkError(message: String) {
        hideLoadingIndicator()
        
        let alert = AlertModel(title: "Ошибка", message: message, buttonText: "Попробовать еще раз") { [weak self] in
            guard let self = self else { return }
            self.presenter.restartGame()
        }
        alertPresenter?.showQuizResult(model: alert)
    }

    func show(quiz step: QuizStepViewModel) {
        UIView.transition(with: imageView,
                                  duration: 0.3,
                                  options: .transitionCrossDissolve,
                                  animations: { self.imageView.image = step.image},
                                  completion: nil)
        imageView.image = step.image
        imageView.layer.cornerRadius = 20
        imageView.animationDuration = 1
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    func highlightImageBorder(isCorrect: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.cornerRadius = 20
        if isCorrect {
            imageView.layer.borderColor = UIColor.ypGreen.cgColor
        } else {
            imageView.layer.borderColor = UIColor.ypRed.cgColor
        }
    }
}
