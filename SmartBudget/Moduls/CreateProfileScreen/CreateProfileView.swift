import UIKit

private extension String {
    static let nameTextFieldPlaceholder = "Введите имя"
    static let lastNameTextFieldPlaceholder = "Введите фамилию"
    static let continueButtonText = "Продолжить"
    static let clueText = "Допустимы буквы, дефисы и апострофы \n (2–50 символов)"
}

final class CreateProfileView: UIView {

    // MARK: Properties
    private var buttonFactory: ButtonFactory
    private var textFieldFactory: TextFieldFactory

    // MARK: UI Elements
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray6
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = .profileCornerRadius
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private(set) lazy var addAvatarButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(resource: .plusAvatar)
        let scaledImage = image.resized(to: CGSize(width: .profileAddButtonImageSize, height: .profileAddButtonImageSize))
        button.setImage(scaledImage, for: .normal)
        return button
    }()

    private(set) lazy var nameTextField: TextFieldView = {
        let textField = textFieldFactory.createTextFieldView(type: .default, placeholder: .nameTextFieldPlaceholder)
        textField.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.authScaledHeight)
        }
        return textField
    }()

    private(set) lazy var lastNameTextField: TextFieldView = {
        let textField = textFieldFactory.createTextFieldView(type: .default, placeholder: .lastNameTextFieldPlaceholder)
        textField.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.authScaledHeight)
        }
        return textField
    }()

    private(set) lazy var continueButton: IButton = {
        buttonFactory.createButton(type: .standard, title: .continueButtonText)
    }()

    private lazy var clueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = .clueText
        label.textAlignment = .center
        label.numberOfLines = 2
        label.isHidden = true
        label.font = .systemFont(ofSize: .defaultFontSize)
        return label
    }()

    private lazy var fullNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, lastNameTextField])
        stackView.axis = .vertical
        stackView.spacing = .authSpacing
        stackView.distribution = .equalSpacing
        return stackView
    }()

    // MARK: Initialization
    init(buttonFactory: ButtonFactory, textFieldFactory: TextFieldFactory) {
        self.buttonFactory = buttonFactory
        self.textFieldFactory = textFieldFactory
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
        let isKeyboardVisible = keyboardRect.height > 0

        avatarImageView.snp.updateConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(isKeyboardVisible ? CGFloat.profileKeyboardVisibleTopOffset : CGFloat.profileKeyboardHiddenTopOffset)
        }

        fullNameStackView.snp.updateConstraints { make in
            make.centerY.equalToSuperview().offset(isKeyboardVisible ? 0 : CGFloat.profileStackViewCenterOffset)
        }

        layoutIfNeeded()
    }

    func setupAvatar(image: UIImage) {
        avatarImageView.image = image
    }

    func showClue(_ show: Bool) {
        clueLabel.isHidden = show
    }

    // MARK: Private Methods
    private func addSubviews() {
        addSubview(avatarImageView)
        addSubview(fullNameStackView)
        addSubview(addAvatarButton)
        addSubview(continueButton)
        addSubview(clueLabel)
    }

    private func setupLayout() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(CGFloat.profileAvatarTopOffset)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGFloat.profileScaledAvatarSize)
        }

        addAvatarButton.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.top).offset(CGFloat.profileScaledAddButtonOffset)
            make.leading.equalTo(avatarImageView.snp.leading).offset(CGFloat.profileScaledAddButtonOffset)
        }

        fullNameStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.authScaledHorizontalInset)
            make.centerY.equalToSuperview().offset(CGFloat.profileStackViewCenterOffset)
        }

        clueLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.authScaledHorizontalInset)
            make.bottom.equalTo(continueButton.snp.top).offset(-CGFloat.profileClueBottomOffset)
        }

        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(CGFloat.authScaledBottomInset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.authSpacing)
        }
    }
}
