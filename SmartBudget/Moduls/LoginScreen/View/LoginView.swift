import UIKit
import SnapKit

private extension CGFloat {
    static let bottomPadding: CGFloat = 12
    static let spacing: CGFloat = 16
    static let baseHeight: CGFloat = 50
    static let baseLogoSize: CGFloat = 110
    static let baseBottomInset: CGFloat = 30
    static let baseHorizontalInset: CGFloat = 30
    static let baseStackBottomOffset: CGFloat = 100

    static var scaledHeight: CGFloat { baseHeight * (screenWidth / baseWidth) }

    static var scaledLogoSize: CGFloat { baseLogoSize * (screenWidth / baseWidth) }

    static var scaledBottomInset: CGFloat { baseBottomInset * (screenWidth / baseWidth) }

    static var scaledHorizontalInset: CGFloat { baseHorizontalInset * (screenWidth / baseWidth) }

    static var scaledStackBottomOffset: CGFloat { baseStackBottomOffset * (screenWidth / baseWidth) }
}

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

    private lazy var loginTextField: TextFieldView = {
        let textField = textFieldFactory.createTextFieldView(type: .email, placeholder: "Логин")
        textField.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.scaledHeight)
        }
        return textField
    }()

    private(set) lazy var passwordTextField: TextFieldView = {
        let textField = textFieldFactory.createTextFieldView(type: .password, placeholder: "Пароль", rightButton: passwordVisibilityToggleButton)
        textField.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.scaledHeight)
        }
        return textField
    }()

    private lazy var authStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginTextField, passwordTextField])
        stackView.spacing = .spacing
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        return stackView
    }()

    private(set) lazy var loginButton: IButton = {
        buttonFactory.createButton(type: .standard, title: "Войти")
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
            make.size.equalTo(CGFloat.scaledLogoSize)
            make.bottom.equalTo(authStackView.snp.top).inset(-CGFloat.scaledStackBottomOffset + (isKeyboardVisible ? .baseHorizontalInset : 0))
        }

        authStackView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.scaledHorizontalInset)
            make.bottom.equalTo(isKeyboardVisible ?
                superview.snp.bottom : loginButton.snp.top
            ).offset(isKeyboardVisible ?
                     -keyboardRect.height - .baseHorizontalInset : -CGFloat.scaledStackBottomOffset
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
            make.size.equalTo(CGFloat.scaledLogoSize)
            make.bottom.equalTo(authStackView.snp.top).inset(-CGFloat.scaledStackBottomOffset)
        }

        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(registrationButton.snp.top).inset(-CGFloat.bottomPadding)
            make.leading.trailing.equalToSuperview().inset(CGFloat.spacing)
        }

        registrationButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(CGFloat.scaledBottomInset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.spacing)
        }

        authStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.scaledHorizontalInset)
            make.bottom.equalTo(loginButton.snp.top).offset(-CGFloat.scaledStackBottomOffset)
        }
    }
}
