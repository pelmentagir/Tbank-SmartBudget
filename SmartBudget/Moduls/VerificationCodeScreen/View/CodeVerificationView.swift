import UIKit
import Combine

private extension CGFloat {
    static let fieldSpacing: CGFloat = 16
    static let fieldSize: CGFloat = 56
    static let infoToSubInfoSpacing: CGFloat = 20
    static let defaultSpacing: CGFloat = 30
    static let timerToKeyboardSpacing: CGFloat = 60
}

final class CodeVerificationView: UIView {

    // MARK: Properties
    weak var delegate: CodeVerificationViewDelegate?
    private let textFieldFactory: TextFieldFactory
    private var codeFields: [CodeTextField] = []
    private let codeLength = 4
    private var textFieldDelegate: CodeVerificationTextFieldDelegate?

    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите код"
        label.font = .boldSystemFont(ofSize: .highFontSize)
        label.textAlignment = .center
        return label
    }()

    private lazy var subInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Отправили код подтверждения на почту\nexample@gmail.com"
        label.font = .systemFont(ofSize: .defaultFontSize)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "Отправим код повторно через 59 сек"
        label.font = .systemFont(ofSize: .defaultFontSize)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()

    private lazy var codeStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = .fieldSpacing
        stack.distribution = .fillEqually
        return stack
    }()

    init(textFieldFactory: TextFieldFactory) {
        self.textFieldFactory = textFieldFactory
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setupFields()
        addSubviews()
        firstResponder()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    func updateTimerText(_ text: String) {
        timerLabel.text = text
    }

    func updateEmailText(_ email: String) {
        subInfoLabel.text = "Отправили код подтверждения на почту\n\(email)"
    }

    func updateField(at index: Int, text: String, isEnabled: Bool) {
        guard index < codeFields.count else { return }
        codeFields[index].text = text
        codeFields[index].isEnabled = isEnabled
        if isEnabled {
            codeFields[index].becomeFirstResponder()
        }
    }

    // MARK: Private Methods
    private func setupFields() {
        for i in 0..<codeLength {
            let fieldView = textFieldFactory.createTextFieldView(type: .code, placeholder: "")
            guard let field = fieldView.getField() as? CodeTextField else { continue }
            field.tag = i
            field.isEnabled = i == 0
            field.onDeleteBackward = { [weak self] in
                self?.delegate?.didDeleteBackward(at: field.tag)
            }

            codeFields.append(field)
            codeStack.addArrangedSubview(fieldView)
        }

        textFieldDelegate = CodeVerificationTextFieldDelegate(delegate: self, codeFields: codeFields)
        codeFields.forEach { $0.delegate = textFieldDelegate }
    }

    private func addSubviews() {
        addSubview(infoLabel)
        addSubview(subInfoLabel)
        addSubview(codeStack)
        addSubview(timerLabel)
    }

    private func setupLayout() {

        infoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(subInfoLabel.snp.top).offset(-CGFloat.infoToSubInfoSpacing)
        }

        subInfoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(codeStack.snp.top).offset(-CGFloat.defaultSpacing)
        }

        codeStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(CGFloat.fieldSize)
            make.width.equalTo((CGFloat.fieldSize * CGFloat(codeLength)) + (CGFloat.fieldSpacing * CGFloat(codeLength - 1)))
            make.bottom.lessThanOrEqualTo(timerLabel.snp.top).offset(-CGFloat.defaultSpacing)
        }

        timerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.lessThanOrEqualTo(keyboardLayoutGuide.snp.top).offset(-CGFloat.timerToKeyboardSpacing)
        }
    }

    private func firstResponder() {
        codeFields[0].becomeFirstResponder()
    }
}

// MARK: - CodeVerificationViewDelegate

extension CodeVerificationView: CodeVerificationViewDelegate {
    func didUpdateCode(at index: Int, with value: String) {
        delegate?.didUpdateCode(at: index, with: value)
    }

    func didDeleteBackward(at index: Int) {
        delegate?.didDeleteBackward(at: index)
    }
}
