import UIKit
import Combine

final class MainViewController: UIViewController, FlowController {

    private var mainView: MainView {
        self.view as! MainView
    }

    // MARK: Properties
    private var viewModel: MainViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    var completionHandler: ((Int) -> Void)?
    private var categoryCollectionViewDataSource: CategoryBudgetDataSource?

    // MARK: Initialization
    init(viewModel: MainViewModelProtocol) {
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let mockTitle = "Почти исчерпан лимит"
            let mockBody = "Вы потратили 50% бюджета на развлечение"
            let notification = UNMutableNotificationContent()
            notification.title = mockTitle
            notification.body = mockBody
            notification.sound = .defaultRingtone

            let notificationRequest = UNNotificationRequest(
                identifier: "string",
                content: notification,
                trigger: nil
            )

            self.viewModel.mockPush(request: notificationRequest)
        }
    }

    // MARK: Private Methods
    private func configureCollectionView() {
        categoryCollectionViewDataSource = CategoryBudgetDataSource(tableView: mainView.tableView)
    }

    private func setupBindings() {
        viewModel.chartItemsPublisher
            .sink { [weak self] items in
                self?.mainView.configurePie(with: items)
                self?.categoryCollectionViewDataSource?.applySnapshot(categories: items, animated: true)
            }.store(in: &cancellables)

        viewModel.leftIncomePublisher
            .sink { [weak self] leftIncome in
                self?.mainView.setLeftIncome(left: leftIncome)
            }.store(in: &cancellables)

        viewModel.spentIncomePublisher
            .sink { [weak self] spentIncome in
                self?.mainView.setSpentIncome(spent: spentIncome)
            }.store(in: &cancellables)
    }
}
