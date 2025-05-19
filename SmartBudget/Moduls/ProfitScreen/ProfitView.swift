import UIKit

private extension String {
    static let stepText = "Шаг 1 из 2"
    static let titleText = "Укажите ваш доход"
    static let defaultProfit = "0"
    static let finalAmountLabelText = "Итоговая сумма: "
    static let buttonText = "Продолжить"
}

class ProfitView: UIView {

    private var textFieldFactory: ITextFieldFactory
    private var buttonFactory: IButtonFactory

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

    private lazy var profitTextField: TextFieldView = {
        let textField = textFieldFactory.createTextFieldView(type: .numeric, placeholder: .defaultProfit, rightButton: nil)
        textField.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.authScaledHeight)
        }
        return textField
    }()

    private(set) lazy var amountCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: 90, height: 30)
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumInteritemSpacing = 8

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(AmountCollectionViewCell.self, forCellWithReuseIdentifier: AmountCollectionViewCell.reuseIdentifier)
        return collectionView
    }()

    private lazy var finalAmountLabel: UILabel = {
        let label = UILabel()
        label.text = .finalAmountLabelText
        label.font = .systemFont(ofSize: .defaultFontSize, weight: .medium)
        return label
    }()

    private lazy var finalAmountValueLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: .highFontSize)
        return label
    }()

    private lazy var continueButton: IButton = {
        buttonFactory.createButton(type: .standard, title: .buttonText, state: .disabled, font: .systemFont(ofSize: .defaultFontSize))
    }()

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
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(16)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(stepLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }

        profitTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(26)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        amountCollectionView.snp.makeConstraints { make in
            make.top.equalTo(profitTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(30)
        }

        finalAmountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(continueButton.snp.top).offset(-30)
            make.leading.equalToSuperview().offset(16)
        }

        finalAmountValueLabel.snp.makeConstraints { make in
            make.bottom.equalTo(continueButton.snp.top).offset(-30)
            make.leading.equalTo(finalAmountLabel.snp.trailing).offset(2)
            make.trailing.equalToSuperview().offset(-16)
        }

        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(CGFloat.authScaledBottomInset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.authSpacing)
        }
    }
}
