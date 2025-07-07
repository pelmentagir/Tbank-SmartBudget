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
        let coordinator = AdditingGoalCoordinator(navigationController: navigationController, appContainer: appContainer, financialGoalService: FinancialGoalService(networkService: .shared))
        coordinator.imagePickerCoordinator = ImagePickerCoordinator(navigationController: navigationController, appContainer: appContainer, type: .photo)
        coordinator.start()
        coordinator.flowCompletionHandler = { [weak self] in
            self?.showTabBarFlow()
        }
        childrens.append(coordinator)
    }

    private lazy var showEdittingProfileScreenAction = UIAction { [weak self] _ in
        guard let self else { return }
        let profileViewModel = appContainer.resolveViewModel(ProfileViewModel.self)
        let controller =  appContainer.resolveController(EdittingProfileViewController.self, argument: profileViewModel.getCurrentUser())

        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: navigationController, appContainer: appContainer, type: .avatar)

        controller.presentImagePicker = {
            imagePickerCoordinator.start()
        }

        imagePickerCoordinator.didSelectImage = { image in
            controller.handleAvatarImage(image: image)
        }

        controller.completionHandler = { [weak self] user in
            profileViewModel.changeUser(user)
            self?.navigationController.popViewController(animated: true)
        }

        navigationController.pushViewController(controller, animated: true)
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

        operationController.presentCalendar = { [weak self] in

               guard let self else { return }
               let rangeController = appContainer.resolveController(RangeDatePickerViewController.self)
               rangeController.completionHandler = { spendingRequest in
                   operationController.requestNewRangeDate(request: spendingRequest)
               }
               rangeController.configurePresentation()
               rangeController.transitioningDelegate = operationController
               navigationController.present(rangeController, animated: true)

        }

        let mainViewController = appContainer.resolveController(MainViewController.self)
        mainViewController.tabBarItem = UITabBarItem(title: "Главная", image: UIImage.donutСhart, selectedImage: UIImage.donutСhart)
        mainViewController.completionHandler = { [weak self] leftMoney in
            guard let self else { return }
            let distributionController = appContainer.resolveController(IncomeDistributionViewController.self)
            distributionController.handleLeftMoney(leftMoney)
            navigationController.present(distributionController, animated: true)
        }

        let savingController = appContainer.resolveController(SavingViewController.self)
        savingController.tabBarItem = UITabBarItem(title: "Накопления", image: UIImage.piggyBank, selectedImage: UIImage.piggyBank)

        let profileController = appContainer.resolveController(ProfileViewController.self)
        profileController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage.profile, selectedImage: UIImage.profile)

        profileController.presentCategoryDistributionScreen = { [weak self] in
            guard let self else { return }
            let categoryDistributionController = appContainer.resolveController(CategoryDistributionViewController.self)
            categoryDistributionController.hideStepTitle()
            navigationController.pushViewController(categoryDistributionController, animated: true)
        }

        savingController.presentReplenishView = { [weak self] savingGoal in
            guard let self else { return }
            showReplenishFlow(with: savingGoal, rootController: savingController)
        }

        tabBarController.viewControllers = [operationController, mainViewController, savingController, profileController]
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
        replenishController.configurePresentation()
        replenishController.transitioningDelegate = rootController
        navigationController.present(replenishController, animated: true)
    }

    private func showEdittingProfileFlow() {

    }
}

extension MainCoordinator: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        switch viewController {
        case is SavingViewController:
            tabBarController.navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: showAddingCoordinator)
        case is ProfileViewController:
            tabBarController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: AppIcon.squareAndPencil.image, primaryAction: showEdittingProfileScreenAction)
        default:
            tabBarController.navigationItem.rightBarButtonItem = nil
        }
        return true
    }
}
