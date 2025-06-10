import UIKit

private extension String {
    static let buttonText = "Пополнить"
}

private extension CGFloat {
    static let cornerRadiusImageBackgroundView: CGFloat = 12
    static let cornerRadiusProgressView: CGFloat = 6
    static let buttonHeight: CGFloat = 48
    static let heightProgressView: CGFloat = 12
    static let heightImageBackgroundView: CGFloat = 160
}

final class SavingTargetTableViewCell: UITableViewCell, SavingTargetTableViewCellProtocol {

    // MARK: Properties
    private lazy var buttonFactory = ButtonFactory()
    private var replenishAction: UIAction?

    // MARK: UI Elements
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = .cornerRadius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.08
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = .smallPadding
        return view
    }()

    private lazy var imageBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(resource: .customYellow2)
        view.layer.cornerRadius = .cornerRadiusImageBackgroundView
        return view
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.defaultPhoto
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: .defaultFontSize)
        label.textColor = .label
        return label
    }()

    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .normalFontSize)
        label.textColor = .secondaryLabel
        return label
    }()

    private lazy var progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progressTintColor = UIColor(resource: .customYellow)
        progress.trackTintColor = UIColor.systemGray5
        progress.layer.cornerRadius = .cornerRadiusProgressView
        progress.layer.masksToBounds = true
        return progress
    }()

    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .normalFontSize)
        label.textColor = .secondaryLabel
        return label
    }()

    private lazy var monthlyGoalLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: .normalFontSize)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()

    private lazy var replenishButton: IButton = buttonFactory.createButton(type: .standard, title: .buttonText, height: .buttonHeight)

    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCicle
    override func prepareForReuse() {
        super.prepareForReuse()

        if let action = replenishAction {
            replenishButton.removeAction(action, for: .touchUpInside)
            replenishAction = nil
        }
    }

    // MARK: Public Methods
    func configureCell(item: SavingGoal, monthlySaving: Int, onReplenish: @escaping () -> Void) {
        titleLabel.text = item.title
        amountLabel.text = "\(item.accumulatedMoney)₽ / \(item.totalCost)₽"
        let progress = Float(item.accumulatedMoney)/Float(item.totalCost)

        monthlyGoalLabel.text = "Цель: отложить \(monthlySaving)₽ в этом месяце"

        progressView.setProgress(progress, animated: false)
        percentLabel.text = "\(Int(progress * 100))%"

        let action = UIAction { _ in
            onReplenish()
        }
        replenishButton.addAction(action, for: .touchUpInside)
        replenishAction = action
    }

    // MARK: Private Methods
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(amountLabel)
        containerView.addSubview(progressView)
        containerView.addSubview(percentLabel)
        containerView.addSubview(monthlyGoalLabel)
        containerView.addSubview(imageBackgroundView)
        imageBackgroundView.addSubview(iconImageView)
        containerView.addSubview(replenishButton)
    }

    private func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(CGFloat.largePadding)
        }

        imageBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(CGFloat.heightImageBackgroundView)
        }

        iconImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(CGFloat.heightProgressView)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageBackgroundView.snp.bottom).offset(CGFloat.largePadding)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
        }

        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.smallPadding)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
        }

        progressView.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.bottom).offset(CGFloat.smallPadding)
            make.leading.equalToSuperview().inset(CGFloat.largePadding)
            make.height.equalTo(CGFloat.heightProgressView)
            make.trailing.equalTo(percentLabel.snp.leading).offset(-CGFloat.smallPadding)
        }

        percentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(progressView)
            make.trailing.equalToSuperview().inset(CGFloat.largePadding)
            make.leading.equalTo(progressView.snp.trailing).offset(CGFloat.smallPadding)
        }

        monthlyGoalLabel.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(CGFloat.smallPadding)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
        }

        replenishButton.snp.makeConstraints { make in
            make.top.equalTo(monthlyGoalLabel.snp.bottom).offset(CGFloat.largePadding)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
            make.bottom.equalToSuperview().inset(CGFloat.largePadding)
        }
    }
}

extension SavingTargetTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
