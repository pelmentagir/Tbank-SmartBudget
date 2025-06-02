import UIKit
import Combine

final class ThirdScreenAddingGoalViewController: UIViewController, FlowController {
    private var addingGoalView: ThirdScreenAddingGoalView {
        self.view as! ThirdScreenAddingGoalView
    }

    // MARK: Properties
    private var viewModel: ThirdScreenAddingGoalViewModel
    private var cancellable = Set<AnyCancellable>()
    var completionHandler: ((Date) -> Void)?

    // MARK: UI Actions
    private lazy var dateChangedAction = UIAction { [weak self] _ in
        guard let self = self else { return }
        let selectedDate = addingGoalView.datePicker.date
        viewModel.setSelectedDay(day: selectedDate)
    }

    private lazy var continueButtonOnTapped = UIAction { [weak self] _ in
        guard let self = self else { return }
        completionHandler?(viewModel.selectedDay)
    }

    // MARK: Initialization
    init(viewModel: ThirdScreenAddingGoalViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCicle
    override func loadView() {
        self.view = ThirdScreenAddingGoalView(buttonFactory: ButtonFactory())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDatePicker()
        setupBindings()
        setupAction()
    }

    // MARK: Private Methods
    private func setupAction() {
        addingGoalView.continueButton.addAction(continueButtonOnTapped, for: .touchUpInside)
    }

    private func configureDatePicker() {
        addingGoalView.datePicker.addAction(dateChangedAction, for: .valueChanged)
    }

    private func setupBindings() {
        viewModel.$daysDifference
            .removeDuplicates()
            .compactMap({ $0 })
            .sink { [weak self] daysDifference in
                guard let self else { return }
                addingGoalView.setDaysRemaining(day: daysDifference)
            }.store(in: &cancellable)
    }
}
