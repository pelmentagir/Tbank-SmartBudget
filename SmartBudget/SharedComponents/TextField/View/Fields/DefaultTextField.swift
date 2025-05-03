import UIKit

final class DefaultTextField: UITextField, ITextField {

    // MARK: Properties
    var isValid: Bool { true }

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
