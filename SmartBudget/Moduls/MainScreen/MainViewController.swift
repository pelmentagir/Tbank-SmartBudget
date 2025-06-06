import UIKit
import Combine

final class MainViewController: UIViewController, FlowController {

    private var mainView: MainView {
        self.view as! MainView
    }

    // MARK: Properties
    private var viewModel: MainViewModel
    private var cancellables = Set<AnyCancellable>()
    var completionHandler: ((Int) -> Void)?
    private var categoryCollectionViewDataSource: CategoryBudgetDataSource?

    // MARK: Initialization
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCicle
    override func loadView() {
        self.view = MainView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupBindings()
        completionHandler?(viewModel.leftIncome)
    }

    // MARK: Private Methods

    private func configureCollectionView() {
        categoryCollectionViewDataSource = CategoryBudgetDataSource(tableView: mainView.tableView)
    }

    private func setupBindings() {
        viewModel.$chartItems
            .sink { [weak self] items in
                self?.mainView.configurePie(with: items)
                self?.categoryCollectionViewDataSource?.applySnapshot(categories: items, animated: true)
            }.store(in: &cancellables)

        viewModel.$leftIncome
            .sink { [weak self] leftIncome in
                self?.mainView.setLeftIncome(left: leftIncome)
            }.store(in: &cancellables)

        viewModel.$spentIncome
            .sink { [weak self] spentIncome in
                self?.mainView.setSpentIncome(spent: spentIncome)
            }.store(in: &cancellables)
    }
}
