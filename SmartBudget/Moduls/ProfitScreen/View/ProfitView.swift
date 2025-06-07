import UIKit

private extension String {
    static let stepText = "Шаг 1 из 2"
    static let titleText = "Укажите ваш доход"
    static let defaultProfit = "0"
    static let defaultFinalAmountValue = "0 ₽"
    static let finalAmountLabelText = "Итоговая сумма: "
}

private extension CGFloat {
    static let titleTopSpacing: CGFloat = 26
    static let collectionViewHeight: CGFloat = 30
    static let collectionViewItemWidth: CGFloat = 90
    static let collectionViewItemHeight: CGFloat = 30
    static let amountLabelBottomSpacing: CGFloat = 30
    static let animationScale: CGFloat = 0.9
}

final class ProfitView: UIView, ProfitViewProtocol {

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

    private(set) lazy var profitTextField: TextFieldView = {
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

    private lazy var finalAmountLabel: UILabel = {
        let label = UILabel()
        label.text = .finalAmountLabelText
        label.font = .systemFont(ofSize: .regularFontSize, weight: .medium)
        return label
    }()

    private lazy var finalAmountValueLabel: UILabel = {
        let label = UILabel()
        label.text = .defaultFinalAmountValue
        label.font = .boldSystemFont(ofSize: .normalFontSize)
        return label
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
    func setupFinalAmountValue(text: String) {
        let text = text.isEmpty ? "0" : text
        finalAmountValueLabel.alpha = 0
        finalAmountValueLabel.transform = CGAffineTransform(scaleX: .animationScale, y: .animationScale)
        finalAmountValueLabel.text = "\(text) ₽"

        UIView.animate(withDuration: 0.4) {
            self.finalAmountValueLabel.alpha = 1
            self.finalAmountValueLabel.transform = .identity
        }
    }

    func updateTextAtTextField(_ newText: String) {
        self.profitTextField.getField().text = newText
        self.profitTextField.getField().setNeedsDisplay()
    }

    // MARK: Private Methods
    private func addSubviews() {
        addSubview(stepLabel)
        addSubview(titleLabel)
        addSubview(profitTextField)
        addSubview(amountCollectionView)
        addSubview(finalAmountLabel)
        addSubview(finalAmountValueLabel)
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

        profitTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.titleTopSpacing)
            make.leading.equalToSuperview().offset(CGFloat.largePadding)
            make.trailing.equalToSuperview().offset(-CGFloat.largePadding)
        }

        amountCollectionView.snp.makeConstraints { make in
            make.top.equalTo(profitTextField.snp.bottom).offset(CGFloat.largePadding)
            make.leading.equalToSuperview().offset(CGFloat.largePadding)
            make.trailing.equalToSuperview().offset(-CGFloat.largePadding)
            make.height.equalTo(CGFloat.collectionViewHeight)
        }

        finalAmountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(continueButton.snp.top).offset(-CGFloat.amountLabelBottomSpacing)
            make.leading.equalToSuperview().offset(CGFloat.amountLabelBottomSpacing)
        }

        finalAmountValueLabel.snp.makeConstraints { make in
            make.bottom.equalTo(continueButton.snp.top).offset(-CGFloat.amountLabelBottomSpacing)
            make.leading.equalTo(finalAmountLabel.snp.trailing).offset(CGFloat.extraSmallPadding)
            make.trailing.equalToSuperview().offset(-CGFloat.largePadding)
        }

        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(CGFloat.authScaledBottomInset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
        }
    }
}
