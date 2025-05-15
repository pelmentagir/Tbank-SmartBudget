import UIKit

final class AppCoordinator: Coordinator {

    // MARK: Properties
    var childrens: [Coordinator] = []
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
        showAuthFlow()
    }

    // MARK: Private Methods
    private func showAuthFlow() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController, appContainer: appContainer)
        authCoordinator.start()
        childrens.append(authCoordinator)
    }
}
