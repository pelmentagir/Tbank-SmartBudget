import UIKit
import Combine

final class MainViewController: UIViewController, FlowController {

    private var mainView: MainView {
        self.view as! MainView
    }

    private var viewModel: MainViewModel
    private var cancellables = Set<AnyCancellable>()
    var completionHandler: ((String) -> Void)?
    private var categoryCollectionViewDataSource: CategoryBudgetDataSource?

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = MainView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupBindings()
    }

    private func configureCollectionView() {
        categoryCollectionViewDataSource = CategoryBudgetDataSource(tableView: mainView.tableView)
    }

    private func setupBindings() {
        viewModel.$chartItems
            .sink { [weak self] items in
                self?.mainView.configure(with: items)
                self?.categoryCollectionViewDataSource?.applySnapshot(categories: items, animated: true)
            }.store(in: &cancellables)
        
    }
}
