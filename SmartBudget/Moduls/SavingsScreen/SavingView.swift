import UIKit

final class SavingView: UIView {

    // MARK: UI Elements
    private(set) lazy var tableView: UITableView = {
        let tableView = IntrinsicTableView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(SavingTargetTableViewCell.self, forCellReuseIdentifier: SavingTargetTableViewCell.reuseIdentifier)
        return tableView
    }()

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods
    private func addSubviews() {
        addSubview(tableView)
    }

    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
