import UIKit

final class AdditingGoalCoordinator: Coordinator {
    var navigationController: UINavigationController
    private var appContainer: AppContainer
    var imagePickerCoordinator: ImagePickerCoordinator?
    var savingGoal = SavingGoalRequestDTO()
    var flowCompletionHandler: (() -> Void)?

    init(navigationController: UINavigationController, appContainer: AppContainer) {
        self.navigationController = navigationController
        self.appContainer = appContainer
    }

    func start() {
        showFirstView()
    }

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
