import UIKit

private extension String {
    static let stepText = "Шаг 2 из 3"
    static let titleText = "Укажите желаемую сумму"
    static let capitalText = "Сколько уже накопили:"
    static let defaultProfit = "0"
}

private extension CGFloat {
    static let titleTopSpacing: CGFloat = 26
    static let collectionViewHeight: CGFloat = 30
    static let collectionViewItemWidth: CGFloat = 90
    static let collectionViewItemHeight: CGFloat = 30
    static let amountLabelBottomSpacing: CGFloat = 30
    static let animationScale: CGFloat = 0.9
}

final class SecondScreenAddingGoalView: UIView {

    // MARK: Properties
    private var textFieldFactory: ITextFieldFactory
    private var buttonFactory: IButtonFactory

    // MARK: UI Elements
    private lazy var stepLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: .defaultFontSize)
        label.text = .stepText
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: .highFontSize)
        label.text = .titleText
        return label
    }()

    private(set) lazy var totalSumTextField: TextFieldView = {
        let textField = textFieldFactory.createTextFieldView(type: .numeric, placeholder: .defaultProfit, rightButton: nil)

        textField.getField().attributedPlaceholder = NSAttributedString(
            string: .defaultProfit,
            attributes: [
                .foregroundColor: UIColor.black
            ]
        )

        textField.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.authScaledHeight)
        }
        return textField
    }()

    private(set) lazy var amountCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: .collectionViewItemWidth, height: .collectionViewItemHeight)
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumInteritemSpacing = .smallPadding

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(AmountCollectionViewCell.self, forCellWithReuseIdentifier: AmountCollectionViewCell.reuseIdentifier)
        return collectionView
    }()

    private(set) lazy var capitalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .italicFontSize, weight: .medium)
        label.text = .capitalText
        return label
    }()

    private(set) lazy var capitalTextField: TextFieldView = {
        let textField = textFieldFactory.createTextFieldView(type: .numeric, placeholder: .defaultProfit, rightButton: nil)

        textField.getField().attributedPlaceholder = NSAttributedString(
            string: .defaultProfit,
            attributes: [
                .foregroundColor: UIColor.black
            ]
        )

        textField.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.authScaledHeight)
        }
        return textField
    }()

    private(set) lazy var continueButton: IButton = buttonFactory.createButton(
        type: .standard,
        title: .confirmButtonText,
        state: .disabled,
        font: .systemFont(ofSize: .defaultFontSize),
        height: .baseHeight)

    // MARK: Initialization
    init(textFieldFactory: ITextFieldFactory, buttonFactory: IButtonFactory) {
        self.textFieldFactory = textFieldFactory
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
    func updateTextAtTextField(_ newText: String) {
        self.totalSumTextField.getField().text = newText
        self.totalSumTextField.getField().setNeedsDisplay()
    }

    // MARK: Private Methods
    private func addSubviews() {
        addSubview(stepLabel)
        addSubview(titleLabel)
        addSubview(totalSumTextField)
        addSubview(amountCollectionView)
        addSubview(capitalLabel)
        addSubview(capitalTextField)
        addSubview(continueButton)
    }

    private func setupLayout() {
        stepLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(CGFloat.largePadding)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(stepLabel.snp.bottom).offset(CGFloat.largePadding)
            make.leading.equalToSuperview().offset(CGFloat.largePadding)
        }

        totalSumTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.titleTopSpacing)
            make.leading.equalToSuperview().offset(CGFloat.largePadding)
            make.trailing.equalToSuperview().offset(-CGFloat.largePadding)
        }

        amountCollectionView.snp.makeConstraints { make in
            make.top.equalTo(totalSumTextField.snp.bottom).offset(CGFloat.largePadding)
            make.leading.equalToSuperview().offset(CGFloat.largePadding)
            make.trailing.equalToSuperview().offset(-CGFloat.largePadding)
            make.height.equalTo(CGFloat.collectionViewHeight)
        }

        capitalLabel.snp.makeConstraints { make in
            make.top.equalTo(amountCollectionView.snp.bottom).offset(CGFloat.bigPadding)
            make.leading.equalToSuperview().offset(CGFloat.largePadding)
            make.trailing.equalToSuperview().offset(-CGFloat.largePadding)
        }

        capitalTextField.snp.makeConstraints { make in
            make.top.equalTo(capitalLabel.snp.bottom).offset(CGFloat.largePadding)
            make.leading.equalToSuperview().offset(CGFloat.largePadding)
            make.trailing.equalToSuperview().offset(-CGFloat.largePadding)
        }

        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(CGFloat.authScaledBottomInset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
        }
    }
}
