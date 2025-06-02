import UIKit

final class AuthCoordinator: Coordinator {

    // MARK: Properties
    var navigationController: UINavigationController
    var appContainer: AppContainer
    var imagePickerCoordinator: ImagePickerCoordinator?
    weak var categoryDistributionController: CategoryDistributionViewController?

    var flowCompletionHandler: (() -> Void)?

    // MARK: Initialization
    init(navigationController: UINavigationController, appContainer: AppContainer) {
        self.navigationController = navigationController
        self.appContainer = appContainer
    }

    // MARK: Public Methods
    func start() {
        /*showLoginFlow()*/
        showCategoryDistributionFlow()
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

    private func showProfitFlow() {
        let controller = appContainer.resolveController(ProfitViewController.self)

        controller.completionHandler = { value in

        }

        navigationController.setViewControllers([controller], animated: true)
    }

    private func showCategoryDistributionFlow() {
        let controller = appContainer.resolveController(CategoryDistributionViewController.self)
        self.categoryDistributionController = controller
        controller.completionHandler = { value in

        }

        controller.presentBudgetPlanning = { [weak self] category in
            self?.showBudgetPlanningFlow(category: category)
        }

        navigationController.setViewControllers([controller], animated: true)
    }

    private func showBudgetPlanningFlow(category: Category) {
        let controller = appContainer.resolveController(BudgetPlanningViewController.self, argument: category)

        controller.completionHandler = { [weak self] category in
            self?.categoryDistributionController?.addCategoryInTag(category: category)
            controller.dismiss(animated: true)
        }

        let navController = UINavigationController(rootViewController: controller)

        navController.modalPresentationStyle = .formSheet

        navigationController.present(navController, animated: true)
    }
}
