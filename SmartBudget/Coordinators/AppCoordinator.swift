import UIKit

final class AppCoordinator: Coordinator {

    // MARK: Properties
    var childrens: [Coordinator] = []
    var navigationController: UINavigationController
    private let appContainer: AppContainer

    var flowCompletionHandler: (() -> Void)?

    // MARK: Initialization
    init(navigationController: UINavigationController, appContainer: AppContainer) {
        self.navigationController = navigationController
        self.appContainer = appContainer
        start()
    }

    // MARK: Public Methods
    func start() {
        if AuthenticationManager.shared.isAuthenticated {
            showMainFlow()
        } else {
            showAuthFlow()
        }
    }

    // MARK: Private Methods
    private func showAuthFlow() {
        let authCoordinator = AuthCoordinator(
            navigationController: navigationController,
            appContainer: appContainer
        )
        authCoordinator.imagePickerCoordinator = ImagePickerCoordinator(navigationController: navigationController, appContainer: appContainer, type: .avatar)
        authCoordinator.start()

        authCoordinator.flowCompletionHandler = { [weak self] in
            AuthenticationManager.shared.signIn()
            self?.showMainFlow()
        }

        childrens.append(authCoordinator)
    }

    private func showMainFlow() {
        let mainCoordinator = MainCoordinator(
            navigationController: navigationController,
            appContainer: appContainer)
        mainCoordinator.start()
        childrens.append(mainCoordinator)
    }
}
