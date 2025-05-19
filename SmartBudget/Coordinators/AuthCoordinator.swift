import UIKit

final class AuthCoordinator: Coordinator {

    // MARK: Properties
    var navigationController: UINavigationController
    var appContainer: AppContainer
    var imagePickerCoordinator: ImagePickerCoordinator?

    var flowCompletionHandler: (() -> Void)?

    // MARK: Initialization
    init(navigationController: UINavigationController, appContainer: AppContainer) {
        self.navigationController = navigationController
        self.appContainer = appContainer
        start()
    }

    // MARK: Public Methods
    func start() {
        /*showLoginFlow()*/
        showCreateProfileFlow()
    }

    // MARK: Private Methods
    private func showLoginFlow() {
        let controller = appContainer.resolveController(LoginViewController.self)
        controller.completionHandler = { [weak self] user in
            if user != nil {
                self?.showCodeFlow()
            } else {
                self?.showRegistrationFlow()
            }

        }
        navigationController.setViewControllers([controller], animated: true)
    }

    private func showCodeFlow() {
        let controller = appContainer.resolveController(CodeVerificationViewController.self)

        controller.completionHandler = { [weak self] _ in

        }

        navigationController.setViewControllers([controller], animated: true)
    }

    private func showRegistrationFlow() {
        let controller = appContainer.resolveController(RegistrationViewController.self)

        controller.completionHandler = { [weak self] user in
            self?.showCodeFlow()
        }
        navigationController.pushViewController(controller, animated: true)
    }

    private func showCreateProfileFlow() {
        let controller = appContainer.resolveController(CreateProfileViewController.self)

        controller.completionHandler = { [weak self] user in

        }

        controller.presentImagePicker = { [weak self] in
            guard let self else { return }
            imagePickerCoordinator?.start()
        }

        imagePickerCoordinator?.didSelectImage = { image in
            controller.handleAvatarImage(image: image)
        }

        navigationController.setViewControllers([controller], animated: true)
    }
}
