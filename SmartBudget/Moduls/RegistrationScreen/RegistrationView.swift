import UIKit

private extension String {
    static let loginTextFieldPlaceholder = "Почта"
    static let passwordTextFieldPlaceholder = "Пароль"
    static let confirmTextFieldPlaceholder = "Повторите пароль"
    static let clueText = "Пароли не совпадают"
    static let registrationButtonText = "Зарегистрироваться"
}

final class RegistrationView: UIView {

    // MARK: Properties
    private let textFieldFactory: TextFieldFactory
    private let buttonFactory: ButtonFactory

    // MARK: UI Elements
    private lazy var tbankLogo: UIImageView = {
        let image = UIImageView(image: .tBankLogo)
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()

    private(set) lazy var loginTextField: TextFieldView = {
        let textField = textFieldFactory.createTextFieldView(type: .email, placeholder: .loginTextFieldPlaceholder)
        textField.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.authScaledHeight)
        }
        return textField
    }()

    private(set) lazy var passwordTextField: TextFieldView = {
        let textField = textFieldFactory.createTextFieldView(type: .password, placeholder: .passwordTextFieldPlaceholder)
        textField.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.authScaledHeight)
        }
        return textField
    }()

    private(set) lazy var passwordConfirmTextField: TextFieldView = {
        let textField = textFieldFactory.createTextFieldView(type: .password, placeholder: .confirmTextFieldPlaceholder)
        textField.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.authScaledHeight)
        }
        return textField
    }()

    private lazy var authStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginTextField, passwordTextField, passwordConfirmTextField])
        stackView.spacing = .largePadding
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        return stackView
    }()

    private lazy var clueLabel: UILabel = {
        let label = UILabel()
        label.text = .clueText
        label.font = .systemFont(ofSize: .defaultFontSize, weight: .regular)
        label.textColor = .systemRed
        label.isHidden = true
        return label
    }()

    private(set) lazy var registrationButton: IButton = buttonFactory.createButton(type: .standard, title: .registrationButtonText, state: .disabled)

    // MARK: Initialization
    init(textFieldFactory: TextFieldFactory, buttonFactory: ButtonFactory) {
        self.textFieldFactory = textFieldFactory
        self.buttonFactory = buttonFactory
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        addSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    func updateLayout(keyboardRect: CGRect = .zero) {
        guard let superview = self.superview else { return }
        let isKeyboardVisible = keyboardRect.height > 0

        tbankLogo.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGFloat.authScaledLogoSize)
            make.bottom.equalTo(authStackView.snp.top).inset(-CGFloat.authScaledStackBottomOffset + (isKeyboardVisible ? .authBaseHeight : 0))
        }

        authStackView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.authScaledHorizontalInset)
            make.bottom.equalTo(clueLabel.snp.top).inset(-CGFloat.largePadding)
        }

        clueLabel.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(isKeyboardVisible ?
                                superview.snp.bottom : registrationButton.snp.top
            ).offset(isKeyboardVisible ?
                     -keyboardRect.height - .largePadding : -CGFloat.authScaledStackBottomOffset
            )
        }

        layoutIfNeeded()
    }

    func visableClue(_ state: Bool) {
        clueLabel.isHidden = state
    }

    // MARK: Private Methods
    private func addSubviews() {
        addSubview(tbankLogo)
        addSubview(authStackView)
        addSubview(registrationButton)
        addSubview(clueLabel)
    }

    private func setupLayout() {
        tbankLogo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGFloat.authScaledLogoSize)
            make.bottom.equalTo(authStackView.snp.top).inset(-CGFloat.authScaledStackBottomOffset)
        }

        registrationButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(CGFloat.authScaledBottomInset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
        }

        authStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.authScaledHorizontalInset)
            make.bottom.equalTo(clueLabel.snp.top).offset(-CGFloat.mediumPadding)
        }

        clueLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(registrationButton.snp.top).offset(-CGFloat.authScaledStackBottomOffset)
        }
    }
}
