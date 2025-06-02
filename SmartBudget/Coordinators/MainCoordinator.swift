import UIKit

class MainCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController

    var flowCompletionHandler: (() -> Void)?
    let appContainer: AppContainer
    var childrens: [Coordinator] = []

    init(navigationController: UINavigationController, appContainer: AppContainer) {
        self.navigationController = navigationController
        self.appContainer = appContainer
    }
    
    private lazy var showAddingCoordinator = UIAction { [weak self] _ in
        guard let self else { return }
        let coordinator = AdditingGoalCoordinator(navigationController: navigationController, appContainer: appContainer)
        coordinator.imagePickerCoordinator = ImagePickerCoordinator(navigationController: navigationController, appContainer: appContainer, type: .photo)
        coordinator.start()
        coordinator.flowCompletionHandler = { [weak self] in
            self?.showTabBarFlow()
        }
        childrens.append(coordinator)
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
        
        savingController.presentReplenishView = { [weak self] savingGoal in
            guard let self else { return }
            let replenishController = appContainer.resolveController(ReplenishViewController.self, argument: savingGoal)
            replenishController.completionHandler = { savingGoal in
                savingController.replenishAmount(goal: savingGoal)
                replenishController.dismiss(animated: true)
            }
            replenishController.modalPresentationStyle = .custom
            replenishController.modalTransitionStyle = .coverVertical
            replenishController.transitioningDelegate = savingController
            savingController.present(replenishController, animated: true)
        }

        tabBarController.viewControllers = [operationController, mainViewController, savingController]
        tabBarController.tabBar.setupTinkoffStyle()

        tabBarController.delegate = self

        navigationController.setViewControllers([tabBarController], animated: true)
    }
}

extension MainCoordinator: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        switch viewController {
        case is SavingViewController:
            tabBarController.navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: showAddingCoordinator)
        default:
            tabBarController.navigationItem.rightBarButtonItem = nil
        }
        return true
    }
}
