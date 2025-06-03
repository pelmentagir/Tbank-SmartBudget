import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    var flowCompletionHandler: (() -> Void)?
    let appContainer: AppContainer

    init(navigationController: UINavigationController, appContainer: AppContainer) {
        self.navigationController = navigationController
        self.appContainer = appContainer
    }

    func start() {
        showTabBarFlow()
    }

    private func showTabBarFlow() {
        let tabBarController = UITabBarController()

        let operationController = appContainer.resolveController(OperationViewController.self)
        operationController.tabBarItem = UITabBarItem(title: "Операции", image: UIImage.operations, selectedImage: UIImage.operations)

        let mainViewController = appContainer.resolveController(MainViewController.self)
        mainViewController.tabBarItem = UITabBarItem(title: "Главная", image: UIImage.donutСhart, selectedImage: UIImage.donutСhart)

        let savingController = appContainer.resolveController(SavingViewController.self)
        savingController.tabBarItem = UITabBarItem(title: "Накопления", image: UIImage.piggyBank, selectedImage: UIImage.piggyBank)
        
        let profileController = appContainer.resolveController(ProfileViewController.self)
        profileController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage.profile, selectedImage: UIImage.profile)

        tabBarController.viewControllers = [operationController, mainViewController, savingController, profileController]
        tabBarController.tabBar.setupTinkoffStyle()

        navigationController.setViewControllers([tabBarController], animated: true)
    }
}
