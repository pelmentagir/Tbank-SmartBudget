import UIKit
import SnapKit

final class LoginView: UIView {

    // MARK: Properties
    private let textFieldFactory: TextFieldFactory
    private let buttonFactory: ButtonFactory

    // MARK: UI
    private lazy var tbankLogo: UIImageView = {
        let image = UIImageView(image: .tBankLogo)
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()

    private(set) lazy var passwordVisibilityToggleButton: UIButton = {
        let button = UIButton()
        button.setImage(AppIcon.eye.image, for: .normal)
        return button
    }()

    private(set) lazy var loginTextField: TextFieldView = {
        let textField = textFieldFactory.createTextFieldView(type: .email, placeholder: "Логин")
        textField.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.authScaledHeight)
        }
        return textField
    }()

    private(set) lazy var passwordTextField: TextFieldView = {
        let textField = textFieldFactory.createTextFieldView(type: .password, placeholder: "Пароль", rightButton: passwordVisibilityToggleButton)
        textField.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.authScaledHeight)
        }
        return textField
    }()

    private lazy var authStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginTextField, passwordTextField])
        stackView.spacing = .authSpacing
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        return stackView
    }()

    private(set) lazy var loginButton: IButton = {
        let button = buttonFactory.createButton(type: .standard, title: "Войти", state: .disabled)
        return button
    }()

    private(set) lazy var registrationButton: IButton = {
        buttonFactory.createButton(type: .outline, title: "Регистрация")
    }()

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
            make.bottom.equalTo(authStackView.snp.top).inset(-CGFloat.authScaledStackBottomOffset + (isKeyboardVisible ? .authBaseHorizontalInset : 0))
        }

        authStackView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.authScaledHorizontalInset)
            make.bottom.equalTo(isKeyboardVisible ?
                superview.snp.bottom : loginButton.snp.top
            ).offset(isKeyboardVisible ?
                     -keyboardRect.height - .authBaseHorizontalInset : -CGFloat.authScaledStackBottomOffset
            )
        }

        layoutIfNeeded()
    }

    func updatePasswordVisibility(_ isVisible: Bool) {
        let field = passwordTextField.getField()
        field.isSecureTextEntry = !isVisible
        passwordVisibilityToggleButton.setImage(isVisible ? AppIcon.eyeSlash.image : AppIcon.eye.image, for: .normal)
    }

    // MARK: Private Methods
    private func addSubviews() {
        addSubview(tbankLogo)
        addSubview(authStackView)
        addSubview(loginButton)
        addSubview(registrationButton)
    }

    private func setupLayout() {
        tbankLogo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGFloat.authScaledLogoSize)
            make.bottom.equalTo(authStackView.snp.top).inset(-CGFloat.authScaledStackBottomOffset)
        }

        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(registrationButton.snp.top).inset(-CGFloat.authBottomPadding)
            make.leading.trailing.equalToSuperview().inset(CGFloat.authSpacing)
        }

        registrationButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(CGFloat.authScaledBottomInset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.authSpacing)
        }

        authStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.authScaledHorizontalInset)
            make.bottom.equalTo(loginButton.snp.top).offset(-CGFloat.authScaledStackBottomOffset)
        }
    }
}
