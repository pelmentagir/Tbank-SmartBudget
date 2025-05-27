import UIKit
import Combine

final class BudgetPlanningViewController: UIViewController, FlowController {

    private var budgetPlanningView: BudgetPlanningView {
        self.view as! BudgetPlanningView
    }

    // MARK: Properties
    private let viewModel: BudgetPlanningViewModel
    private var cancellables = Set<AnyCancellable>()

    private lazy var searchResultsViewController = SearchResultsViewController(viewModel: SearchViewModel())
    private var searchBarDelegate: SearchBarDelegate?

    var completionHandler: ((Category) -> Void)?

    // MARK: UI Actions
    private lazy var sliderAction = UIAction { [weak self] action in
        guard let self, let slider = action.sender as? CustomSlider else { return }
        viewModel.calculateAmount(slider.value)
    }

    private lazy var confirmButtonOnTapped = UIAction { [weak self] _ in
        guard let self else { return }
        if let category = viewModel.getFinalCategory() {
            completionHandler?(category)
        }
    }

    // MARK: SearchController
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: searchResultsViewController)
        searchController.showsSearchResultsController = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.setValue("Отмена", forKey: "cancelButtonText")
        definesPresentationContext = true
        searchController.searchResultsUpdater = searchResultsViewController
        return searchController
    }()

    // MARK: Initialization
    init(viewModel: BudgetPlanningViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: LifeCicle
    override func loadView() {
        self.view = BudgetPlanningView(buttonFactory: ButtonFactory())
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchController()
        configureSlider()
        setupBindings()
        setupAction()

        if viewModel.category == nil {
            budgetPlanningView.hideViews(true)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods
    private func setupSearchController() {
        searchBarDelegate = SearchBarDelegate()
        searchBarDelegate?.viewModel = viewModel
        searchController.searchBar.delegate = searchBarDelegate
        navigationItem.searchController = searchController
        searchResultsViewController.onCategorySelected = { [weak self] category in
            self?.viewModel.setCategory(category)
        }
    }

    private func configureSlider() {
        budgetPlanningView.slider.addAction(sliderAction, for: .valueChanged)
    }

    private func setupAction() {
        budgetPlanningView.confirmButton.addAction(confirmButtonOnTapped, for: .touchUpInside)
    }

    private func setupBindings() {
        viewModel.$category
            .removeDuplicates()
            .sink { [weak self] category in
                guard let self else { return }

                if let category {
                    if budgetPlanningView.isHiddenViews {
                        budgetPlanningView.hideViews(false)
                    }
                    budgetPlanningView.setupView(category: category)

                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.searchController.isActive = true
                        self?.searchController.searchBar.setShowsCancelButton(false, animated: true)
                        self?.searchController.searchBar.becomeFirstResponder()
                    }
                }
            }
            .store(in: &cancellables)

        viewModel.$selectedAmount
            .sink { [weak self] amount in
                self?.budgetPlanningView.setAmount(amount)
            }
            .store(in: &cancellables)

        viewModel.$percentage
            .sink { [weak self] percentage in
                self?.budgetPlanningView.setPercentage(percentage)
            }.store(in: &cancellables)

        viewModel.$buttonState
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] buttonState in
                self?.budgetPlanningView.confirmButton.buttonViewModel.buttonState = buttonState
            }.store(in: &cancellables)
    }
}
