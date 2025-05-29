import UIKit

final class CategoryBudgetTableViewCell: UITableViewCell {

    // MARK: UI Elements
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.08
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 8
        return view
    }()

    private lazy var iconBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.2)
        return view
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .label
        return label
    }()

    private lazy var spentLabel: UILabel = {
        let label = UILabel()
        label.text = "Потрачено:"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()

    private lazy var spentValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        return label
    }()

    private lazy var remainingLabel: UILabel = {
        let label = UILabel()
        label.text = "Осталось:"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()

    private lazy var remainingValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        return label
    }()

    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemGray
        return label
    }()

    private lazy var spentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [spentLabel, spentValueLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        return stackView
    }()

    private lazy var percentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [remainingLabel, remainingValueLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        return stackView
    }()

    private lazy var infoAmountStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [spentStackView, percentStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    func configure(category: CategorySpendingDTO) {
        iconImageView.image = UIImage.getIconByCategory(categoryName: category.categoryName)
        iconBackgroundView.backgroundColor = UIColor.getBackgroundColorByCategory(categoryName: category.categoryName).withAlphaComponent(.alphaBackgorundViewCategory)
        titleLabel.text = category.categoryName
        spentValueLabel.text = "\(category.spentMoney)₽"
        remainingValueLabel.text = "\(category.leftMoney)₽"
        percentLabel.text = "\(category.percent)%"
    }

    // MARK: Private Methods
    private func setupLayout() {
        contentView.addSubview(containerView)

        containerView.addSubview(iconBackgroundView)
        iconBackgroundView.addSubview(iconImageView)

        containerView.addSubview(titleLabel)
        containerView.addSubview(infoAmountStackView)
        containerView.addSubview(percentLabel)

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }

        iconBackgroundView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(16)
            make.size.equalTo(40)
        }

        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(24)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconBackgroundView.snp.trailing).offset(12)
            make.centerY.equalTo(iconBackgroundView)
            make.trailing.lessThanOrEqualTo(percentLabel.snp.leading).offset(-8)
        }

        percentLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(iconBackgroundView)
        }

        infoAmountStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(iconImageView.snp.bottom).offset(16)
        }
    }
}

extension CategoryBudgetTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
