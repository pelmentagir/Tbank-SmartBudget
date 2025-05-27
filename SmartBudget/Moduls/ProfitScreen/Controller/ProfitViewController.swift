import UIKit
import Combine

final class ProfitViewController: UIViewController, FlowController {

    private var profitView: ProfitView {
        self.view as! ProfitView
    }

    // MARK: Properties
    private var viewModel: ProfitViewModel
    private var amountCollectionViewDataSource: AmountCollectionViewDataSource?
    private var amountCollectionViewDelegate: AmountCollectionViewDelegate?

    private var profitTextFieldDelegate: ProfitTextFieldDelegate?

    private var cancellable = Set<AnyCancellable>()
    var completionHandler: ((Int) -> Void)?

    // MARK: Initialization
    init(viewModel: ProfitViewModel) {
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
        setupBindings()
    }

    // MARK: Private Methods
    private func setupBindings() {
        viewModel.$currentProfit
            .compactMap({ String($0) })
            .sink { [weak self] profit in
                guard let self else { return }
                profitView.setupFinalAmountValue(text: profit)
            }.store(in: &cancellable)

        viewModel.$selectedIndexInCollectionView
            .sink { [weak self] index in
                guard let self else { return }
                if index != nil {
                    profitView.updateTextAtTextField(viewModel.getCurrentProfit())
                } else if let prevIndex = viewModel.selectedIndexInCollectionView {
                    profitView.amountCollectionView.deselectItem(at: IndexPath(item: prevIndex, section: 0), animated: true)
                    profitView.updateTextAtTextField(viewModel.getCurrentProfit())
                }
            }.store(in: &cancellable)

        viewModel.$valid
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] valid in
                self?.profitView.continueButton.buttonViewModel.buttonState = valid ? .normal : .disabled
            }.store(in: &cancellable)
    }

    private func configureCollectionView() {
        amountCollectionViewDelegate = AmountCollectionViewDelegate()
        amountCollectionViewDataSource = AmountCollectionViewDataSource(viewModel: viewModel)

        profitView.amountCollectionView.dataSource = amountCollectionViewDataSource
        profitView.amountCollectionView.delegate = amountCollectionViewDelegate

        amountCollectionViewDelegate?.viewModel = viewModel
    }

    private func configureTextField() {
        profitTextFieldDelegate = ProfitTextFieldDelegate()
        profitView.profitTextField.getField().delegate = profitTextFieldDelegate
        profitTextFieldDelegate?.viewModel = viewModel
    }
}
