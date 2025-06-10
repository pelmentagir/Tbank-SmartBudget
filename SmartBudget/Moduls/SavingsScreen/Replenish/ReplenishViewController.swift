import UIKit
import Combine

final class ReplenishViewController: UIViewController, FlowController {

    private var replenishView: ReplenishView {
        self.view as! ReplenishView
    }

    // MARK: Properties
    private var viewModel: ReplenishViewModelProtocol
    private var amountCollectionViewDataSource: AmountCollectionViewDataSource?
    private var amountCollectionViewDelegate: AmountCollectionViewDelegate?

    private var profitTextFieldDelegate: ProfitTextFieldDelegate?

    private var cancellable = Set<AnyCancellable>()
    var completionHandler: ((SavingGoal) -> Void)?

    private lazy var replenishButtonOnTapped = UIAction { [weak self] _ in
        guard let self else { return }
        viewModel.applyReplenishmentAmountOnSavingGoal()
    }

    // MARK: Initialization
    init(viewModel: ReplenishViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCicle
    override func loadView() {
        self.view = ReplenishView(textFieldFactory: TextFieldFactory(), buttonFactory: ButtonFactory())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        modalTransitionStyle = .coverVertical
        modalPresentationStyle = .custom
        configureCollectionView()
        configureTextField()
        setupBindings()
        setupAction()
    }
    
    // MARK: Public Methods
    func configurePresentation() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .coverVertical
    }

    // MARK: Private Methods
    private func setupAction() {
        replenishView.replenishButton.addAction(replenishButtonOnTapped, for: .touchUpInside)
    }

    private func setupBindings() {
        viewModel.selectedIndexInCollectionViewPublisher
            .sink { [weak self] index in
                guard let self else { return }
                if index != nil {
                    replenishView.updateTextAtTextField(viewModel.getCurrentReplenishmentAmount())
                } else if let prevIndex = viewModel.selectedIndexInCollectionView {
                    replenishView.amountCollectionView.deselectItem(at: IndexPath(item: prevIndex, section: 0), animated: true)
                    replenishView.updateTextAtTextField(viewModel.getCurrentReplenishmentAmount())
                }
            }.store(in: &cancellable)

        viewModel.validPublisher
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] valid in
                self?.replenishView.replenishButton.buttonViewModel.buttonState = valid ? .normal : .disabled
            }.store(in: &cancellable)

        viewModel.amountPublished
            .sink { [weak self] amount in
                self?.amountCollectionViewDataSource?.applySnapshot(items: amount, animated: false)
            }.store(in: &cancellable)

        viewModel.savingGoalPublished
            .dropFirst()
            .sink { [weak self] goal in
                self?.completionHandler?(goal)
            }.store(in: &cancellable)
    }

    private func configureCollectionView() {
        amountCollectionViewDelegate = AmountCollectionViewDelegate()
        amountCollectionViewDataSource = AmountCollectionViewDataSource(collectionView: replenishView.amountCollectionView)

        replenishView.amountCollectionView.delegate = amountCollectionViewDelegate

        amountCollectionViewDelegate?.viewModel = viewModel
    }

    private func configureTextField() {
        profitTextFieldDelegate = ProfitTextFieldDelegate()
        replenishView.profitTextField.getField().delegate = profitTextFieldDelegate
        profitTextFieldDelegate?.viewModel = viewModel
    }
}
