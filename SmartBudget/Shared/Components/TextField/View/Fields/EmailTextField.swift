import UIKit
import Combine

final class EmailTextField: UITextField, ITextField {

    // MARK: Properties
    var isValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self.text)
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
        keyboardType = .emailAddress
        autocorrectionType = .no
        autocapitalizationType = .none
    }
}
