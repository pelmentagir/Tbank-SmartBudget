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
    private var viewModel: OperationViewModel
    private var cancellables = Set<AnyCancellable>()
    private var operationTableViewDataSource: OperationTableViewDataSource?
    private var operationTableViewDelegate: OperationTableViewDelegate?
    var completionHandler: ((String) -> Void)?
    var presentCalendar: (() -> Void)?

    private lazy var timeRangeButtonOnTapped = UIAction { [weak self] _ in
        self?.presentCalendar?()
    }

    // MARK: Initialization
    init(viewModel: OperationViewModel) {
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

    // MARK: Private Methods
    private func setupAction() {
        operationView.timeRangeButton.addAction(timeRangeButtonOnTapped, for: .touchUpInside)
    }

    private func configureTableView() {
        operationTableViewDataSource = OperationTableViewDataSource(tableView: operationView.tableView)

        operationTableViewDelegate = OperationTableViewDelegate(viewModel: viewModel)
        operationView.tableView.delegate = operationTableViewDelegate
    }

    private func setupBindings() {
        viewModel.$operation
            .sink { [weak self] operation in
                self?.operationTableViewDataSource?.applySnapshot(with: operation.daysInfo)
                self?.operationView.configure(totalAmount: operation.totalSpentMoney)
            }.store(in: &cancellables)
    }
}

// MARK: UIViewControllerTransitioningDelegate

extension OperationViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomHeightPresentationController(presentedViewController: presented, presenting: presenting, customHeigth: .modalScreenHeight)
    }
}
