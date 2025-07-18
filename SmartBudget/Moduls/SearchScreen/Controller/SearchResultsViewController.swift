import UIKit
import Combine

final class SearchResultsViewController: UIViewController {

    private var searchView: SearchResultView {
        self.view as! SearchResultView
    }

    // MARK: Properties
    private let viewModel: SearchViewModelProtocol
    private var searchTableViewDataSource: SearchTableViewDataSource?
    private var searchTableViewDelegate: SearchTableViewDelegate?
    private var cancellables = Set<AnyCancellable>()

    var onCategorySelected: ((CategoryItem) -> Void)?

    // MARK: Initialization
    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LyfeCicle
    override func loadView() {
        self.view = SearchResultView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupBindings()
    }

    // MARK: Private Methods
    private func setupBindings() {
        viewModel.categoriesPublisher
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] categories in
                self?.searchTableViewDataSource?.applySnapshot(categories: categories, animated: false)
            }.store(in: &cancellables)

        viewModel.selectedCategoryPublisher
            .dropFirst()
            .sink { [weak self] category in
                guard let self, let category else { return }
                onCategorySelected?(category)
                dismiss(animated: true)
            }.store(in: &cancellables)
    }

    private func configureTableView() {
        searchTableViewDataSource = SearchTableViewDataSource(tableView: searchView.tableView)
        searchTableViewDelegate = SearchTableViewDelegate()
        searchTableViewDelegate?.viewModel = viewModel
        searchView.tableView.delegate = searchTableViewDelegate
    }
}

// MARK: - UISearchResultsUpdating

extension SearchResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text?.lowercased() ?? ""
        viewModel.search(query: query)
    }
}
