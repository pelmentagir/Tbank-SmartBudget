import UIKit
import Combine

private extension CGFloat {
    static let modalScreenHeight: CGFloat = .screenHeight * 0.6
}

final class OperationViewController: UIViewController, FlowController {
    private var operationView: OperationView {
        self.view as! OperationView
    }

    // MARK: Properties
    private var viewModel: OperationViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    private var operationTableViewDataSource: OperationTableViewDataSource?
    private var operationTableViewDelegate: OperationTableViewDelegate?
    var completionHandler: ((String) -> Void)?
    var presentCalendar: (() -> Void)?

    private lazy var timeRangeButtonOnTapped = UIAction { [weak self] _ in
        self?.presentCalendar?()
    }

    // MARK: Initialization
    init(viewModel: OperationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCicle
    override func loadView() {
        self.view = OperationView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupBindings()
        setupAction()
    }

    func requestNewRangeDate(request: SpendingRequest) {
        viewModel.fetchSpendingData(request: request)
    }

    // MARK: Private Methods
    private func setupAction() {
        operationView.timeRangeButton.addAction(timeRangeButtonOnTapped, for: .touchUpInside)
    }

    private func configureTableView() {
        operationTableViewDataSource = OperationTableViewDataSource(tableView: operationView.tableView)
        operationTableViewDelegate = OperationTableViewDelegate(viewModel: viewModel)
        operationView.tableView.delegate = operationTableViewDelegate
        viewModel.updateTable = { [weak self] in
            self?.operationView.tableView.reloadData()
        }
    }

    private func setupBindings() {
        viewModel.spendingResponsePublisher
            .dropFirst()
            .sink { [weak self] operation in
                guard let self else { return }
                operationTableViewDataSource?.applySnapshot(with: operation.daysInfo)
                operationView.configure(totalAmount: operation.totalSpentMoney)
            }.store(in: &cancellables)

        viewModel.progressPublisher
            .sink { [weak self] progress in
                self?.operationView.updateProgress(progress)
            }
            .store(in: &cancellables)
    }
}

// MARK: UIViewControllerTransitioningDelegate

extension OperationViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomHeightPresentationController(presentedViewController: presented, presenting: presenting, customHeigth: .modalScreenHeight)
    }
}
