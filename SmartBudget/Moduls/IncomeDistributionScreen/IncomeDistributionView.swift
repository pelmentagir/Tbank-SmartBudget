import UIKit

private extension String {
    static let titleText = "Зарплата пришла!"
    static let subtitleText = "Зарплата уже на счету"
    static func description(remainingAmount: Int) -> String {
        return "У тебя осталось \(remainingAmount)₽ с прошлого месяца.\nХочешь распределить их по целям?"
    }
    static let buttonText = "Распределить по целям"
}

private extension CGFloat {
    static let distributionButtonTopPadding: CGFloat = 24
    static let pointSizeIconButton: CGFloat = 20
    static let tableRowHeight: CGFloat = 90
}

final class IncomeDistributionView: UIView {

    // MARK: Properties
    private let buttonFactory: IButtonFactory

    // MARK: UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = .titleText
        label.font = .systemFont(ofSize: .highFontSize, weight: .bold)
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = .subtitleText
        label.font = .systemFont(ofSize: .italicFontSize, weight: .medium)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: .defaultFontSize, weight: .regular)
        return label
    }()

    private(set) lazy var distributionButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()

    private lazy var buttonLabel: UILabel = {
        let label = UILabel()
        label.text = .buttonText
        label.font = .systemFont(ofSize: .defaultFontSize, weight: .regular)
        return label
    }()

    private(set) lazy var confirmButton: IButton = buttonFactory.createButton(
        type: .standard,
        title: .confirmButtonText,
        state: .normal,
        font: .systemFont(ofSize: .defaultFontSize),
        height: CGFloat.baseHeight)

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = .tableRowHeight
        tableView.separatorStyle = .none
        tableView.register(CategoryDistributionTableViewCell.self, forCellReuseIdentifier: CategoryDistributionTableViewCell.reuseIdentifier)
        return tableView
    }()

    // MARK: Initialization
    init(buttonFactory: IButtonFactory) {
        self.buttonFactory = buttonFactory
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        addSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    func setupLeftMoney(amount: Int) {
        descriptionLabel.text = .description(remainingAmount: amount)
    }

    func toogleStateDistribution(_ state: Bool) {
        print(state)
        tableView.isHidden = state
        let icon = state ? AppIcon.squareFill.image : AppIcon.checkmarkSquareFill.image
        let config = UIImage.SymbolConfiguration(pointSize: .pointSizeIconButton, weight: .medium)
        let image = icon?.withConfiguration(config)
        distributionButton.setImage(image, for: .normal)
        distributionButton.tintColor = state ? .systemGray5 : .customBlue
    }

    // MARK: Private Methods
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(descriptionLabel)
        addSubview(distributionButton)
        addSubview(tableView)
        addSubview(buttonLabel)
        addSubview(confirmButton)
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(CGFloat.bigPadding)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.bigPadding)
            make.trailing.leading.equalToSuperview().inset(CGFloat.largePadding)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(CGFloat.smallPadding)
            make.trailing.leading.equalToSuperview().inset(CGFloat.largePadding)
        }

        distributionButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(CGFloat.distributionButtonTopPadding)
            make.leading.equalToSuperview().inset(CGFloat.largePadding)
        }

        buttonLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(CGFloat.largePadding)
            make.centerY.equalTo(distributionButton.snp.centerY)
            make.leading.equalTo(distributionButton.snp.trailing).offset(CGFloat.smallPadding)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(buttonLabel.snp.bottom).offset(CGFloat.largePadding)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
            make.bottom.equalTo(confirmButton.snp.top).offset(-CGFloat.largePadding)
        }

        confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(CGFloat.authScaledBottomInset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
        }
    }
}
