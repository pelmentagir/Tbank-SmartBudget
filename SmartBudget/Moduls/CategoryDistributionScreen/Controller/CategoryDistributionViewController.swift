import UIKit
import Combine

final class CategoryDistributionViewController: UIViewController, FlowController, CategoryDistributionControllerProtocol {

    private var categoryDistributionView: CategoryDistributionView {
        self.view as! CategoryDistributionView
    }

    // MARK: Properties
    var completionHandler: (([String]) -> Void)?
    var presentBudgetPlanning: ((Category) -> Void)?

    private var viewModel: CategoryDistributionViewModelProtocol
    private var cancellables = Set<AnyCancellable>()

    private var tagsCollectionViewDataSource: TagsCollectionViewDataSource?

    private var categoryCollectionViewDataSource: CategoryCollectionViewDataSource?
    private var categoryCollectionViewDelegate: CategoryCollectionViewDelegate?

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
    }

    // MARK: Public Methods
    func hideStepTitle() {
        categoryDistributionView.stepLabel.isHidden = true
    }
    
    func addCategoryInTag(category: Category) {
        viewModel.appendCategory(category)
    }

    // MARK: Private Methods
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
    }
}
