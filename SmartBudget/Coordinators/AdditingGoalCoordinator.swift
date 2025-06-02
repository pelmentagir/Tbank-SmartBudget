import UIKit

final class AdditingGoalCoordinator: Coordinator {

    // MARK: Properties
    private var savingGoal = SavingGoalRequestDTO()
    private let appContainer: AppContainer
    var navigationController: UINavigationController
    var imagePickerCoordinator: ImagePickerCoordinator?
    var flowCompletionHandler: (() -> Void)?

    // MARK: Initialization
    init(navigationController: UINavigationController, appContainer: AppContainer) {
        self.navigationController = navigationController
        self.appContainer = appContainer
    }

    // MARK: Public Methods
    func start() {
        showFirstView()
    }

    // MARK: Private Methods
    private func showFirstView() {
        let controller = appContainer.resolveController(FirstScreenAddingGoalViewController.self)
        controller.completionHandler = { [weak self] targetName in
            guard let self else { return }
            savingGoal.title = targetName
            showSecondView()
        }

        controller.presentImagePicker = { [weak self] in
            guard let self else { return }
            imagePickerCoordinator?.start()
        }

        imagePickerCoordinator?.didSelectImage = { [weak self] image in
            guard let self else { return }
            savingGoal.image = image
            controller.setupImage(with: image)
        }

        navigationController.pushViewController(controller, animated: true)
    }

    private func showSecondView() {
        let controller = appContainer.resolveController(SecondScreenAddingGoalViewController.self)

        controller.completionHandler = { [weak self] savingBalance in
            guard let self else { return }
            savingGoal.totalCost = savingBalance.totalCost
            savingGoal.accumulatedMoney = savingBalance.accumulatedMoney
            showThirdView()
        }
        navigationController.pushViewController(controller, animated: true)
    }

    private func showThirdView() {
        let controller = appContainer.resolveController(ThirdScreenAddingGoalViewController.self)

        controller.completionHandler = { [weak self] endDate in
            guard let self else { return }
            savingGoal.endDate = endDate
            flowCompletionHandler?()
        }

        navigationController.pushViewController(controller, animated: true)
    }
}
