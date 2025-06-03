import UIKit
import Combine

struct SavingsBalance {
    let totalCost: Int
    let accumulatedMoney: Int
}

final class SecondScreenAddingGoalViewController: UIViewController, FlowController {

    private var addingGoalView: SecondScreenAddingGoalView {
        self.view as! SecondScreenAddingGoalView
    }

    // MARK: Properties
    private var viewModel: SecondAddingGoalViewModelProtocol
    private var amountCollectionViewDataSource: AmountCollectionViewDataSource?
    private var amountCollectionViewDelegate: AmountCollectionViewDelegate?

    private var profitTextFieldDelegate: ProfitTextFieldDelegate?

    private var cancellable = Set<AnyCancellable>()
    var completionHandler: ((SavingsBalance) -> Void)?

    // MARK: UI Actions
    private lazy var continueButtonOnTapped = UIAction { [weak self] _ in
        guard let self else { return }
        let savingBalance = SavingsBalance(totalCost: viewModel.currentTotalSum, accumulatedMoney: viewModel.currentCapitalMoney)
        completionHandler?(savingBalance)
    }

    // MARK: Initialization
    init(viewModel: SecondAddingGoalViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCicle
    override func loadView() {
        self.view = SecondScreenAddingGoalView(textFieldFactory: TextFieldFactory(), buttonFactory: ButtonFactory())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureTextField()
        setupBindings()
        setupAction()
    }

    // MARK: Private Methods
    private func setupAction() {
        addingGoalView.continueButton.addAction(continueButtonOnTapped, for: .touchUpInside)
    }

    private func setupBindings() {
        viewModel.selectedIndexInCollectionViewPublisher
            .sink { [weak self] index in
                guard let self else { return }
                if index != nil {
                    addingGoalView.updateTextAtTextField(viewModel.getCurrentTotalSum())
                } else if let prevIndex = viewModel.selectedIndexInCollectionView {
                    addingGoalView.amountCollectionView.deselectItem(at: IndexPath(item: prevIndex, section: 0), animated: true)
                    addingGoalView.updateTextAtTextField(viewModel.getCurrentTotalSum())
                }
            }.store(in: &cancellable)

        viewModel.validPublisher
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] valid in
                self?.addingGoalView.continueButton.buttonViewModel.buttonState = valid ? .normal : .disabled
            }.store(in: &cancellable)

        viewModel.amountPublished
            .sink { [weak self] amount in
                self?.amountCollectionViewDataSource?.applySnapshot(items: amount, animated: true)
            }.store(in: &cancellable)

        addingGoalView.capitalTextField.textField.textPublisher()
            .sink { [weak self] text in
                self?.viewModel.setCapital(money: text)
            }.store(in: &cancellable)
    }

    private func configureCollectionView() {
        amountCollectionViewDelegate = AmountCollectionViewDelegate()
        amountCollectionViewDataSource = AmountCollectionViewDataSource(collectionView: addingGoalView.amountCollectionView)

        addingGoalView.amountCollectionView.delegate = amountCollectionViewDelegate

        amountCollectionViewDelegate?.viewModel = viewModel
    }

    private func configureTextField() {
        profitTextFieldDelegate = ProfitTextFieldDelegate()
        addingGoalView.totalSumTextField.getField().delegate = profitTextFieldDelegate
        profitTextFieldDelegate?.viewModel = viewModel
    }
}
