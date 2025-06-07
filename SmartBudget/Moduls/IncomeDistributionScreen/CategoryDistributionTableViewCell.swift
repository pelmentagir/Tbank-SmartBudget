import UIKit

private extension CGFloat {
    static let backgroundIconViewSize: CGFloat = 32
    static let icomEdges: CGFloat = 5
}

private extension String {
    static let defaultAmountPlaceholder: String = "0"
}

final class CategoryDistributionTableViewCell: UITableViewCell, CategoryDistributionTableViewCellProtocol {

    // MARK: Properties
    private let textFieldFactory = TextFieldFactory()
    private var maximumAmount: Int = 0

    // MARK: UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: .normalFontSize, weight: .regular)
        return label
    }()

    private(set) lazy var textField: TextFieldView = {
        let textField = textFieldFactory.createTextFieldView(type: .numeric, placeholder: .defaultAmountPlaceholder, rightButton: nil)
        textField.getField().delegate = self
        textField.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.authScaledHeight)
        }
        return textField
    }()

    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubveiws()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    func configureCell(_ savingGoal: SavingGoal) {
        titleLabel.text = savingGoal.title
        maximumAmount = savingGoal.totalCost - savingGoal.accumulatedMoney
    }

    // MARK: Private Methods
    private func addSubveiws() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.smallPadding)
            make.leading.equalToSuperview().inset(CGFloat.largePadding)
        }

        textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.smallPadding)
        }
    }
}

// MARK: - ReuseIdentifier

extension CategoryDistributionTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: - UITextFieldDelegate

extension CategoryDistributionTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text,
              let textRange = Range(range, in: currentText) else {
            return true
        }

        let updatedText = currentText.replacingCharacters(in: textRange, with: string)

        if updatedText.isEmpty {
            return true
        }

        guard let newAmount = Int(updatedText) else {
            return false
        }

        if newAmount > maximumAmount {
            textField.text = String(maximumAmount)
            textField.setNeedsDisplay()
            return false
        }

        return true
    }
}
