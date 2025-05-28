import UIKit

final class CategoryBudgetTableViewCell: UITableViewCell {

    // MARK: UI Elements
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.08
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 8
        return view
    }()

    private let iconBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.2)
        return view
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .label
        return label
    }()

    private let spentLabel: UILabel = {
        let label = UILabel()
        label.text = "Потрачено:"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()

    private let spentValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        return label
    }()

    private let remainingLabel: UILabel = {
        let label = UILabel()
        label.text = "Осталось:"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()

    private let remainingValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        return label
    }()

    private let percentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemGray
        return label
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func configure(
        icon: UIImage?,
        iconBackgroundColor: UIColor,
        title: String,
        spent: String,
        remaining: String,
        percentage: String
    ) {
        iconImageView.image = icon
        iconBackgroundView.backgroundColor = iconBackgroundColor
        titleLabel.text = title
        spentValueLabel.text = spent
        remainingValueLabel.text = remaining
        percentLabel.text = percentage
    }

    // MARK: - Private Methods

    private func setupLayout() {
        contentView.addSubview(containerView)

        containerView.addSubview(iconBackgroundView)
        iconBackgroundView.addSubview(iconImageView)

        containerView.addSubview(titleLabel)
        containerView.addSubview(spentLabel)
        containerView.addSubview(spentValueLabel)
        containerView.addSubview(remainingLabel)
        containerView.addSubview(remainingValueLabel)
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

        spentLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconBackgroundView)
            make.top.equalTo(iconBackgroundView.snp.bottom).offset(16)
        }

        spentValueLabel.snp.makeConstraints { make in
            make.centerX.equalTo(spentLabel)
            make.top.equalTo(spentLabel.snp.bottom).offset(4)
        }

        remainingLabel.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.centerX)
            make.top.equalTo(spentLabel)
        }

        remainingValueLabel.snp.makeConstraints { make in
            make.centerX.equalTo(remainingLabel)
            make.top.equalTo(remainingLabel.snp.bottom).offset(4)
        }
    }
}

extension CategoryBudgetTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
