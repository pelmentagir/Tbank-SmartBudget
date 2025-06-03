import UIKit
import Combine

final class FirstScreenAddingGoalViewController: UIViewController, FlowController {
    private var addingGoalView: FirstScreenAddingGoalView {
        self.view as! FirstScreenAddingGoalView
    }

    // MARK: Properties
    private let viewModel: FirstScreenAddingGoalViewModel
    private var cancellables = Set<AnyCancellable>()
    var completionHandler: ((String) -> Void)?
    var presentImagePicker: (() -> Void)?

    // MARK: UI Actions
    private lazy var addPhotoButtonOnTapped = UIAction { [weak self] _ in
        guard let self else { return }
        presentImagePicker?()
    }

    private lazy var continueButtonOnTapped = UIAction { [weak self] _ in
        guard let self else { return }
        completionHandler?(viewModel.targetName)
    }

    // MARK: Initialization
    init(viewModel: FirstScreenAddingGoalViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCicle
    override func loadView() {
        self.view = FirstScreenAddingGoalView(textFieldFactory: TextFieldFactory(), buttonFactory: ButtonFactory())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAction()
        setupBingings()
    }

    // MARK: Public Methods
    func setupImage(with image: UIImage) {
        addingGoalView.setupImage(with: image)
    }

    // MARK: Private Methods
    private func setupAction() {
        addingGoalView.addPhotoButton.addAction(addPhotoButtonOnTapped, for: .touchUpInside)
        addingGoalView.continueButton.addAction(continueButtonOnTapped, for: .touchUpInside)
    }

    private func setupBingings() {
        addingGoalView.targetTextField.textField.textPublisher()
            .sink { [weak self] text in
                self?.viewModel.setTargetName(name: text)
            }.store(in: &cancellables)

        viewModel.$buttonState
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] state in
                self?.addingGoalView.continueButton.buttonViewModel.buttonState = state
            }.store(in: &cancellables)
    }
}
