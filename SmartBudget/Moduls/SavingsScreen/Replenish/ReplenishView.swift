import UIKit

private extension String {
    static let defaultProfit = "0"
    static let defaultFinalAmountValue = "0 ₽"
    static let buttonText = "Пополнить"
}

private extension CGFloat {
    static let collectionViewHeight: CGFloat = 30
    static let collectionViewItemWidth: CGFloat = 90
    static let collectionViewItemHeight: CGFloat = 30
}

final class ReplenishView: UIView {

    // MARK: Properties
    private var textFieldFactory: ITextFieldFactory
    private var buttonFactory: IButtonFactory

    // MARK: UI Elements
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

    private(set) lazy var replenishButton: IButton = buttonFactory.createButton(
        type: .standard,
        title: .buttonText,
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
        self.profitTextField.getField().text = newText
        self.profitTextField.getField().setNeedsDisplay()
    }

    // MARK: Private Methods
    private func addSubviews() {
        addSubview(profitTextField)
        addSubview(amountCollectionView)
        addSubview(replenishButton)
    }

    private func setupLayout() {
        profitTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.bigPadding)
            make.leading.equalToSuperview().offset(CGFloat.largePadding)
            make.trailing.equalToSuperview().offset(-CGFloat.largePadding)
        }

        amountCollectionView.snp.makeConstraints { make in
            make.top.equalTo(profitTextField.snp.bottom).offset(CGFloat.largePadding)
            make.leading.equalToSuperview().offset(CGFloat.largePadding)
            make.trailing.equalToSuperview().offset(-CGFloat.largePadding)
            make.height.equalTo(CGFloat.collectionViewHeight)
        }

        replenishButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(CGFloat.authScaledBottomInset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
        }
    }
}
