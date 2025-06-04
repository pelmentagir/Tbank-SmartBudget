import UIKit

private extension CGFloat {
    static let avatarImageSize: CGFloat = 100
    static let avatarImageTopPadding: CGFloat = 20
    static let tableTopPadding: CGFloat = 30
    static let rowHeight: CGFloat = 44
}

final class ProfileView: UIView {

    // MARK: UI Elements
    private(set) var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .secondarySystemBackground
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = .rowHeight
        tableView.isScrollEnabled = false
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.reuseIdentifier)
        return tableView
    }()

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.IMG_4382
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray6
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = .avatarImageSize / 2
        return imageView
    }()

    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: .mediumFontSize, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: .defaultFontSize, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        addSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public Methods
    func configure(with profileData: User) {
        fullNameLabel.text = "\(profileData.name) \(profileData.lastName)"
        emailLabel.text = profileData.login
    }

    // MARK: Private Methods
    private func addSubviews() {
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(emailLabel)
        addSubview(tableView)
    }

    private func setupLayout() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(CGFloat.avatarImageTopPadding)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGFloat.avatarImageSize)
        }

        fullNameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(CGFloat.largePadding)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
        }

        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(fullNameLabel.snp.bottom).offset(CGFloat.smallPadding)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(CGFloat.tableTopPadding)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
