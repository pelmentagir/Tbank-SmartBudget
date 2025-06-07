import UIKit
import Combine

private extension CGFloat {
    static let modalScreenHeight: CGFloat = .screenHeight * 0.33
}

final class SavingViewController: UIViewController, FlowController, SavingViewControllerProtocol {
    private var savingView: SavingView {
        self.view as! SavingView
    }

    // MARK: Properties
    private var viewModel: SavingViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    var completionHandler: ((String) -> Void)?
    var presentReplenishView: ((SavingGoal) -> Void)?
    private var savingTargetTableViewDataSource: SavingTargetTableViewDataSource?

    // MARK: Initialization
    init(viewModel: SavingViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCicle
    override func loadView() {
        self.view = SavingView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupBindings()
    }

    // MARK: Public Methods
    func replenishAmount(goal: SavingGoal) {
        viewModel.replenishCartainSavingGoal(goal)
    }

    // MARK: Private Methods
    private func configureTableView() {
        savingTargetTableViewDataSource = SavingTargetTableViewDataSource(tableView: savingView.tableView)
        savingTargetTableViewDataSource?.viewModel = viewModel
    }

    private func setupBindings() {
        viewModel.savingGoalsPublisher.sink { [weak self] items in
            self?.savingTargetTableViewDataSource?.applySnapshot(items: items, animated: false)
        }.store(in: &cancellables)

        savingTargetTableViewDataSource?.onReplenishTapped = { [weak self] savingGoal in
            self?.presentReplenishView?(savingGoal)
        }
    }
}

// MARK: UIViewControllerTransitioningDelegate

extension SavingViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomHeightPresentationController(presentedViewController: presented, presenting: presenting, customHeigth: .modalScreenHeight)
    }
}
