import UIKit

final class NumericTextField: UITextField, ITextField {

    private let rubleFont = UIFont.boldSystemFont(ofSize: .regularFontSize)
    private let rubleColor = UIColor.black
    private let rubleSymbol = "₽"
    private let rubleSpacing: CGFloat = 4

    // MARK: Properties
    var isValid: Bool {
        return Double(self.text ?? "") != nil
    }

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let displayText: String
        let displayFont: UIFont

        if let text = self.text, !text.isEmpty {
            displayText = text
            displayFont = self.font ?? rubleFont
        } else {
            displayText = placeholder ?? ""
            displayFont = self.font ?? rubleFont
        }

        let textRect = self.textRect(forBounds: rect)
        let textWidth = (displayText as NSString).size(withAttributes: [.font: displayFont]).width
        let x = textRect.origin.x + textWidth + rubleSpacing
        let y = (rect.height - rubleFont.lineHeight) / 2
        (rubleSymbol as NSString).draw(at: CGPoint(x: x, y: y), withAttributes: [
            .font: rubleFont,
            .foregroundColor: rubleColor
        ])
    }

    // MARK: Private Methods
    private func setup() {
        font = UIFont.systemFont(ofSize: .regularFontSize)
        keyboardType = .numberPad
        self.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }

    @objc private func textChanged() {
        setNeedsDisplay()
    }
}
