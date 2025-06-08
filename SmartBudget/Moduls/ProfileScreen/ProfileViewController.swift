import UIKit
import Combine

final class ProfileViewController: UIViewController, FlowController {
    private var profileView: ProfileView {
        self.view as! ProfileView
    }

    // MARK: Properties
    private let viewModel: ProfileViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    private var tableViewDataSource: ProfileTableViewDataSource?
    var presentCategoryDistributionScreen: (() -> Void)?

    var completionHandler: ((Bool) -> Void)?

    // MARK: Initialization
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCicle
    override func loadView() {
        self.view = ProfileView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        configureTableView()
    }

    // MARK: Private Methods
    private func setupBindings() {
        viewModel.userPublisher
            .sink { [weak self] user in
                self?.profileView.configure(with: user)
                self?.profileView.tableView.reloadData()
            }.store(in: &cancellables)
    }

    private func configureTableView() {
        tableViewDataSource = ProfileTableViewDataSource(viewModel: viewModel)
        profileView.tableView.dataSource = tableViewDataSource
        profileView.tableView.delegate = self
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 && indexPath.row == 1 {
            presentCategoryDistributionScreen?()
        }
    }
}
