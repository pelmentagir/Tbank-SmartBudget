import UIKit

private extension Int {
    static let minLength = 6
}

final class PasswordTextField: DefaultTextField {

    // MARK: Properties
    override var isValid: Bool {
        return self.text?.count ?? 0 >= .minLength
    }

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods
    private func setup() {
        isSecureTextEntry = true
    }
}
