import UIKit

class CodeTextField: UITextField, ITextField {

    var onDeleteBackward: (() -> Void)?

    var isValid: Bool {
        Double(self.text ?? "") != nil && text?.count == 1
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func deleteBackward() {
        super.deleteBackward()
        onDeleteBackward?()
    }

    private func setup() {
        textAlignment = .center
        keyboardType = .numberPad
        font = .boldSystemFont(ofSize: 24)
    }
}
