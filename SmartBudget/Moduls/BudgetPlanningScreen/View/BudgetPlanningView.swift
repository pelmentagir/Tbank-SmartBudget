import UIKit

private extension String {
    static let descriptionPercentageText = "Процент под категорию"
    static let descriptionAmountText = "Будет выделено:"
}

private extension CGFloat {
    static let budgetIconSize: CGFloat = 80
    static let budgetIconInset: CGFloat = 12
    static let budgetTopOffset: CGFloat = 40
    static let budgetHorizontalOffset: CGFloat = 24
    static let budgetStackSpacing: CGFloat = 16
    static let budgetPlaningTopOffset: CGFloat = 60
    static let budgetAmountBottomOffset: CGFloat = 32
    static let budgetAmountTrailingOffset: CGFloat = 4

    static let budgetStackViewSpacing: CGFloat = 12
    static let budgetInfoStackView: CGFloat = 8
    static let cornerRadiusIconView: CGFloat = 40
}

final class BudgetPlanningView: UIView {

    // MARK: Properties
    private let buttonFactory: ButtonFactory
    private(set) var isHiddenViews = false

    // MARK: UI Elements
    private lazy var iconView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = .cornerRadiusIconView
        return view
    }()

    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .mediumFontSize, weight: .bold)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .normalFontSize, weight: .regular)
        label.numberOfLines = 2
        label.textColor = .customGray2
        return label
    }()

    private(set) lazy var slider = CustomSlider()

    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: .mediumFontSize)
        label.textColor = .label
        return label
    }()

    private lazy var descriptionPercentageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .defaultFontSize, weight: .regular)
        label.text = .descriptionPercentageText
        return label
    }()

    private lazy var descriptionAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .regularFontSize, weight: .medium)
        label.textColor = .label
        label.text = .descriptionAmountText
        return label
    }()

    private lazy var percentageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: .normalFontSize)
        label.textColor = .gray
        return label
    }()

    private(set) lazy var confirmButton: IButton = {
        buttonFactory.createButton(type: .standard, title: .confirmButtonText, state: .disabled)
    }()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = .budgetInfoStackView
        return stackView
    }()

    private lazy var fullInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconView, infoStackView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = .budgetStackSpacing
        return stackView
    }()

    private lazy var percentageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionPercentageLabel, percentageLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private lazy var planingBudgetStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [percentageStackView, slider])
        stackView.axis = .vertical
        stackView.spacing = .budgetStackViewSpacing
        return stackView
    }()

    // MARK: Initialization
    init(buttonFactory: ButtonFactory) {
        self.buttonFactory = buttonFactory
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
        backgroundColor = .systemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    func hideViews(_ state: Bool) {
        isHiddenViews = state
        fullInfoStackView.isHidden = state
        planingBudgetStackView.isHidden = state
        descriptionAmountLabel.isHidden = state
        amountLabel.isHidden = state
        confirmButton.isHidden = state
    }

    func setupView(category: Category) {
        iconView.backgroundColor = category.backgroundColor.withAlphaComponent(.alphaBackgorundViewCategory)

        iconImage.image = category.icon
        titleLabel.text = category.name
        descriptionLabel.text = category.discription
    }

    func setAmount(_ amount: Int) {
        amountLabel.text = "\(amount) ₽"
    }

    func setPercentage(_ percentage: Int) {
        percentageLabel.text = "\(percentage)%"
    }

    // MARK: Private Methods
    private func addSubviews() {
        iconView.addSubview(iconImage)
        addSubview(fullInfoStackView)
        addSubview(planingBudgetStackView)
        addSubview(amountLabel)
        addSubview(descriptionAmountLabel)
        addSubview(confirmButton)
    }

    private func setupLayout() {

        iconView.snp.makeConstraints { make in
            make.width.height.equalTo(CGFloat.budgetIconSize)
        }

        iconImage.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(CGFloat.budgetIconInset)
        }

        fullInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(CGFloat.budgetTopOffset)
            make.leading.equalToSuperview().offset(CGFloat.budgetHorizontalOffset)
            make.trailing.equalToSuperview().offset(-CGFloat.budgetHorizontalOffset)
        }

        planingBudgetStackView.snp.makeConstraints { make in
            make.top.equalTo(fullInfoStackView.snp.bottom).offset(CGFloat.budgetPlaningTopOffset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.budgetStackSpacing)
        }

        descriptionAmountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(confirmButton.snp.top).offset(-CGFloat.budgetAmountBottomOffset)
            make.leading.equalToSuperview().offset(CGFloat.budgetHorizontalOffset)
        }

        amountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(confirmButton.snp.top).offset(-CGFloat.budgetAmountBottomOffset)
            make.leading.equalTo(descriptionAmountLabel.snp.trailing).offset(CGFloat.budgetAmountTrailingOffset)
            make.trailing.equalToSuperview().offset(-CGFloat.budgetHorizontalOffset)
        }

        confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(CGFloat.authScaledBottomInset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.authSpacing)
        }
    }
}
