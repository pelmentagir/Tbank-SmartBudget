import UIKit

final class AuthCoordinator: Coordinator {

    // MARK: Properties
    var navigationController: UINavigationController
    var appContainer: AppContainer

    var flowCompletionHandler: (() -> Void)?

    // MARK: Initialization
    init(navigationController: UINavigationController, appContainer: AppContainer) {
        self.navigationController = navigationController
        self.appContainer = appContainer
        start()
    }

    // MARK: Public Methods
    func start() {
        showLoginFlow()
    }

    // MARK: Private Methods
    private func showLoginFlow() {
        let controller = appContainer.resolveController(LoginViewController.self)
        controller.completionHandler = { [weak self] _ in
            self?.showCodeFlow()

        }
        navigationController.setViewControllers([controller], animated: true)
    }

    private func showCodeFlow() {
        let controller = appContainer.resolveController(CodeVerificationViewController.self)
        navigationController.setViewControllers([controller], animated: true)
    }
}
