import UIKit
import Combine

final class IncomeDistributionViewController: UIViewController, FlowController, IncomeDistributionViewControllerProtocol {
    private var incomeDistributionView: IncomeDistributionView {
        self.view as! IncomeDistributionView
    }

    // MARK: Properties
    private let viewModel: IncomeDistributionViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    private var tableViewDataSource: CategoryDistributionTableDataSource?
    var completionHandler: ((Bool) -> Void)?

    // MARK: Actions
    private lazy var distributionButtonOnTapped = UIAction { [weak self] _ in
        self?.viewModel.hideDistributionTable.toggle()
    }

    private lazy var confirmButtonOnTapped = UIAction { [weak self] _ in
        if let distribution = self?.tableViewDataSource?.getDistributionValues() {
            self?.viewModel.distributeIncome(distribution: distribution)
        }
    }

    // MARK: Initialization
    init(viewModel: IncomeDistributionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCicle
    override func loadView() {
        self.view = IncomeDistributionView(buttonFactory: ButtonFactory())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupActions()
        setupBindings()
    }

    // MARK: Public Methods
    func handleLeftMoney(_ amount: Int) {
        incomeDistributionView.setupLeftMoney(amount: amount)
    }

    // MARK: Private Methods
    private func setupActions() {
        incomeDistributionView.distributionButton.addAction(distributionButtonOnTapped, for: .touchUpInside)
    
        incomeDistributionView.confirmButton.addAction(confirmButtonOnTapped, for: .touchUpInside)
    }

    private func configureTableView() {
        tableViewDataSource = CategoryDistributionTableDataSource(tableView: incomeDistributionView.tableView)
    }

    private func setupBindings() {
        viewModel.savingGoalsPublisher
            .sink { [weak self] goals in
                self?.tableViewDataSource?.applySnapshot(savingGoals: goals)
            }.store(in: &cancellables)

        viewModel.hideDistributionTablePublisher
            .sink { [weak self] state in
                self?.incomeDistributionView.toogleStateDistribution(state)
            }.store(in: &cancellables)
    }
}
