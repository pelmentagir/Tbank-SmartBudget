import UIKit

private extension CGFloat {
    static let defaultPadding: CGFloat = 12
    static let normalPadding: CGFloat = 16
    static let buttonSize: CGFloat = 24
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
                make.leading.equalToSuperview().inset(CGFloat.defaultPadding)
                make.centerY.equalToSuperview()
                make.trailing.equalTo(rightButton.snp.leading).offset(-CGFloat.defaultPadding)
            }

            rightButton.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(CGFloat.normalPadding)
                make.centerY.equalToSuperview()
            }
        } else {
            addSubview(textField)

            textField.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(CGFloat.defaultPadding)
                make.centerY.equalToSuperview()
            }
        }
    }
}
