import UIKit

class DefaultTextField: UITextField, ITextField {

    // MARK: Properties
    private var textFieldDelegate: UITextFieldDelegate?

    var isValid: Bool { true }

    var fieldPlaceholder: String {
        get { placeholder ?? "" }
        set { placeholder = newValue }
    }

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
