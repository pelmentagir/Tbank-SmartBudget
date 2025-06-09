import UIKit
import Combine

final class CategoryDistributionViewController: UIViewController, FlowController, CategoryDistributionControllerProtocol {

    private var categoryDistributionView: CategoryDistributionView {
        self.view as! CategoryDistributionView
    }

    // MARK: Properties
    var completionHandler: ((Bool) -> Void)?
    var presentBudgetPlanning: ((Category) -> Void)?

    private var viewModel: CategoryDistributionViewModelProtocol
    private var cancellables = Set<AnyCancellable>()

    private var tagsCollectionViewDataSource: TagsCollectionViewDataSource?

    private var categoryCollectionViewDataSource: CategoryCollectionViewDataSource?
    private var categoryCollectionViewDelegate: CategoryCollectionViewDelegate?

    private lazy var continueButtonTapped = UIAction { [weak self] _ in
        guard let self else { return }
        viewModel.submitCategoryLimits()
    }
    
    // MARK: Initialization
    init(viewModel: CategoryDistributionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCicle
    override func loadView() {
        super.loadView()
        self.view = CategoryDistributionView(buttonFactory: ButtonFactory())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupBindings()
        setupActions()
    }

    // MARK: Public Methods
    func addCategoryInTag(category: Category) {
        viewModel.appendCategory(category)
    }

    // MARK: Private Methods
    private func setupActions() {
        categoryDistributionView.continueButton.addAction(continueButtonTapped, for: .touchUpInside)
    }
    
    private func configureCollectionView() {
        tagsCollectionViewDataSource = TagsCollectionViewDataSource(collectionView: categoryDistributionView.tagsCollectionView, viewModel: viewModel)
        categoryCollectionViewDataSource = CategoryCollectionViewDataSource(viewModel: viewModel)
        categoryCollectionViewDelegate = CategoryCollectionViewDelegate()
        categoryCollectionViewDelegate?.viewModel = viewModel

        categoryDistributionView.categoryCollectionView.delegate = categoryCollectionViewDelegate
        categoryDistributionView.categoryCollectionView.dataSource = categoryCollectionViewDataSource
    }

    private func setupBindings() {
        viewModel.selectedCategoryPublisher
            .dropFirst()
            .sink { [weak self] category in
                guard let self, let category = category else { return }
                presentBudgetPlanning?(category)
            }.store(in: &cancellables)

        viewModel.tagsPublisher
            .sink { [weak self] tags in
                self?.tagsCollectionViewDataSource?.applySnapshot(tags: tags, animated: true)
            }.store(in: &cancellables)

        viewModel.isLoadingPublisher
            .sink { [weak self] state in
                self?.categoryDistributionView.continueButton.buttonViewModel.buttonState = state ? .loading : .normal
            }.store(in: &cancellables)

        viewModel.successPublisher
            .sink { [weak self] state in
                if state {
                    self?.completionHandler?(true)
                }
            }.store(in: &cancellables)
    }
}
