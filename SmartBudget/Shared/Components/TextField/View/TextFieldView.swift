import UIKit

private extension CGFloat {
    static let buttonSize: CGFloat = 24
}

private extension String {
    static let currencyText = "₽"
}

final class TextFieldView: UIView {

    // MARK: Properties
    let textField: ITextField
    private let rightButton: UIButton?

    // MARK: Initialization
    init(textField: ITextField, rightButton: UIButton? = nil) {
        self.textField = textField
        self.rightButton = rightButton
        super.init(frame: .zero)
        setupLayout()
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    func getField() -> ITextField {
        return textField
    }

    // MARK: Private Methods
    private func setupView() {
        backgroundColor = .customGray
        layer.cornerRadius = .cornerRadius
        clipsToBounds = true
    }

    private func setupLayout() {
        if let rightButton {
            addSubview(rightButton)
            addSubview(textField)

            rightButton.setContentHuggingPriority(.required, for: .horizontal)
            rightButton.setContentCompressionResistancePriority(.required, for: .horizontal)

            textField.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(CGFloat.mediumPadding)
                make.centerY.equalToSuperview()
                make.trailing.equalTo(rightButton.snp.leading).offset(-CGFloat.mediumPadding)
            }

            rightButton.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(CGFloat.largePadding)
                make.centerY.equalToSuperview()
            }
        } else {
            addSubview(textField)

            textField.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(CGFloat.mediumPadding)
                make.centerY.equalToSuperview()
            }
        }
    }
}
