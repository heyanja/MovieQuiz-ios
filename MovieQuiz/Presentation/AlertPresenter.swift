import UIKit

protocol AlertPresenterProtocol {
    
}

class AlertPresenter {
    
    weak var viewController: UIViewController?

    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func showQuizResult(model: AlertModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert)
        alert.view.accessibilityIdentifier = "Game results"
        let action = UIAlertAction(
            title: model.buttonText,
            style: .default) { _ in
                model.completion()}
        
        alert.addAction(action)
        alert.preferredAction = action
        
        viewController?.present(alert, animated: true, completion: nil)
    }
}

