import UIKit

final class NumericTextField: DefaultTextField {

    // MARK: Properties
    override var isValid: Bool {
        return Int(self.text ?? "") != nil
    }

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods
    private func setup() {
        keyboardType = .numberPad
    }
}
