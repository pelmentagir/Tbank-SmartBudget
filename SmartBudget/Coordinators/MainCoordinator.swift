import UIKit

class MainCoordinator: NSObject, Coordinator {

    // MARK: Properties
    private let appContainer: AppContainer
    var navigationController: UINavigationController
    var flowCompletionHandler: (() -> Void)?
    var childrens: [Coordinator] = []

    // MARK: Initialization
    init(navigationController: UINavigationController, appContainer: AppContainer) {
        self.navigationController = navigationController
        self.appContainer = appContainer
    }

    // MARK: Actions
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

    // MARK: Public Methods
    func start() {
        showTabBarFlow()
    }

    // MARK: Private Methods
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
            showReplenishFlow(with: savingGoal, rootController: savingController)
        }

        tabBarController.viewControllers = [operationController, mainViewController, savingController]
        tabBarController.tabBar.setupTinkoffStyle()

        tabBarController.delegate = self

        navigationController.setViewControllers([tabBarController], animated: true)
    }

    private func showReplenishFlow(with savingGoal: SavingGoal, rootController: SavingViewController) {
        let replenishController = appContainer.resolveController(ReplenishViewController.self, argument: savingGoal)
        replenishController.completionHandler = { savingGoal in
            rootController.replenishAmount(goal: savingGoal)
            replenishController.dismiss(animated: true)
        }
        replenishController.modalPresentationStyle = .custom
        replenishController.modalTransitionStyle = .coverVertical
        replenishController.transitioningDelegate = rootController
        navigationController.present(replenishController, animated: true)
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
