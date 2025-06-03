import UIKit
import Combine

final class ProfileViewController: UIViewController, FlowController {
    private var profileView: ProfileView {
        self.view as! ProfileView
    }

    private let viewModel: ProfileViewModel
    private var cancellables = Set<AnyCancellable>()
    private var tableViewDataSource: ProfileTableViewDataSource?
    
    var completionHandler: ((Bool) -> Void)?

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = ProfileView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        configureTableView()
    }

    private func setupBindings() {
        viewModel.$user
            .sink { [weak self] user in
                self?.profileView.configure(with: user)
            }.store(in: &cancellables)
    }
    
    private func configureTableView() {
        tableViewDataSource = ProfileTableViewDataSource(viewModel: viewModel)
        profileView.tableView.dataSource = tableViewDataSource
    }
}
