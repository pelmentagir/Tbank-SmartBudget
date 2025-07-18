import UIKit
import Combine

final class ProfitViewController: UIViewController, FlowController {

    private var profitView: ProfitView {
        self.view as! ProfitView
    }

    // MARK: Properties
    private var viewModel: ProfitViewModelProtocol
    private var amountCollectionViewDataSource: AmountCollectionViewDataSource?
    private var amountCollectionViewDelegate: AmountCollectionViewDelegate?

    private var profitTextFieldDelegate: ProfitTextFieldDelegate?
    private var salaryDayDelegate: SalaryDayTextFieldDelegate?

    private var cancellable = Set<AnyCancellable>()
    var completionHandler: ((Bool) -> Void)?
    
    private lazy var confirmButtonTapped = UIAction { [weak self] _ in
        guard let self else { return }
        viewModel.submitProfitAndSalaryDay()
    }

    // MARK: Initialization
    init(viewModel: ProfitViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCicle
    override func loadView() {
        self.view = ProfitView(textFieldFactory: TextFieldFactory(), buttonFactory: ButtonFactory())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureTextField()
        configureSalaryDayPicker()
        setupBindings()
        setupActions()
    }

    // MARK: Private Methods
    private func setupActions() {
        profitView.continueButton.addAction(confirmButtonTapped, for: .touchUpInside)
    }

    private func setupBindings() {
        viewModel.currentProfitPublisher
            .compactMap({ String($0) })
            .sink { [weak self] profit in
                guard let self else { return }
                profitView.setupFinalAmountValue(text: profit)
            }.store(in: &cancellable)

        viewModel.selectedIndexInCollectionViewPublisher
            .sink { [weak self] index in
                guard let self else { return }
                if index != nil {
                    profitView.updateTextAtTextField(viewModel.getCurrentProfit())
                } else if let prevIndex = viewModel.selectedIndexInCollectionView {
                    profitView.amountCollectionView.deselectItem(at: IndexPath(item: prevIndex, section: 0), animated: true)
                    profitView.updateTextAtTextField(viewModel.getCurrentProfit())
                }
            }.store(in: &cancellable)

        viewModel.validPublisher
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] valid in
                self?.profitView.continueButton.buttonViewModel.buttonState = valid ? .normal : .disabled
            }.store(in: &cancellable)

        viewModel.amountPublished
            .sink { [weak self] amount in
                self?.amountCollectionViewDataSource?.applySnapshot(items: amount, animated: true)
            }.store(in: &cancellable)
        
        viewModel.isLoadingPublisher
            .sink { [weak self] state in
                self?.profitView.continueButton.buttonViewModel.buttonState = state ? .loading : .normal
            }.store(in: &cancellable)
        
        viewModel.successPublisher
            .sink { [weak self] success in
                if success {
                    self?.completionHandler?(true)
                }
            }.store(in: &cancellable)
    }

    private func configureCollectionView() {
        amountCollectionViewDelegate = AmountCollectionViewDelegate()
        amountCollectionViewDataSource = AmountCollectionViewDataSource(collectionView: profitView.amountCollectionView)

        profitView.amountCollectionView.delegate = amountCollectionViewDelegate

        amountCollectionViewDelegate?.viewModel = viewModel
    }

    private func configureTextField() {
        profitTextFieldDelegate = ProfitTextFieldDelegate()
        profitView.profitTextField.getField().delegate = profitTextFieldDelegate
        profitTextFieldDelegate?.viewModel = viewModel
    }

    private func configureSalaryDayPicker() {
        salaryDayDelegate = SalaryDayTextFieldDelegate()
        salaryDayDelegate?.setSalaryDayTextField(profitView.salaryDayTextField.getField())
        salaryDayDelegate?.viewModel = viewModel
    }
}
