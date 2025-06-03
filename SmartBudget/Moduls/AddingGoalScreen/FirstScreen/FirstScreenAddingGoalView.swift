import UIKit

private extension String {
    static let stepText = "Шаг 1 из 3"
    static let targetTextFieldPlaceholder = "Ваша цель"
    static let addButtonText = "Добавить из галереи"
}

private extension CGFloat {
    static let cornerRadiusForImageBackground: CGFloat = 12
    static let addButtonHeight: CGFloat = 50
    static let imageBackgroundViewHeight: CGFloat = 160
}

final class FirstScreenAddingGoalView: UIView {

    // MARK: Properties
    private var textFieldFactory: ITextFieldFactory
    private var buttonFactory: IButtonFactory

    // MARK: UI Elements
    private lazy var stepLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: .defaultFontSize)
        label.text = .stepText
        return label
    }()

    private lazy var imageBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(resource: .customYellow2)
        view.layer.cornerRadius = .cornerRadiusForImageBackground
        return view
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.defaultPhoto
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private(set) lazy var addPhotoButton: UIButton = {
        let button = UIButton(type: .system)

        let configuration = UIButton.Configuration.plain()
        var config = configuration
        config.image = AppIcon.plusCircle.image
        config.imagePadding = .smallPadding
        config.title = .addButtonText
        config.baseForegroundColor = UIColor.systemYellow
        config.attributedTitle = AttributedString(.addButtonText, attributes: AttributeContainer([
            .font: UIFont.boldSystemFont(ofSize: .defaultFontSize)
        ]))

        button.configuration = config

        button.layer.cornerRadius = .cornerRadius
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.clipsToBounds = true

        return button
    }()

    private(set) lazy var targetTextField: TextFieldView = {
        let textField = textFieldFactory.createTextFieldView(type: .default, placeholder: .targetTextFieldPlaceholder, rightButton: nil)
        textField.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.authScaledHeight)
        }
        return textField
    }()

    private(set) lazy var continueButton: IButton = buttonFactory.createButton(
        type: .standard,
        title: .confirmButtonText,
        state: .disabled,
        font: .systemFont(ofSize: .defaultFontSize),
        height: .baseHeight)

    // MARK: Initialization
    init(textFieldFactory: ITextFieldFactory, buttonFactory: IButtonFactory) {
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
    func setupImage(with image: UIImage) {
        iconImageView.isHidden = true
        imageBackgroundView.backgroundColor = .clear
        let backgroundImage = UIImageView(image: image)
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        backgroundImage.layer.cornerRadius = .cornerRadiusForImageBackground
        imageBackgroundView.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: Private Methods
    private func addSubviews() {
        addSubview(stepLabel)
        addSubview(imageBackgroundView)
        imageBackgroundView.addSubview(iconImageView)
        addSubview(addPhotoButton)
        addSubview(targetTextField)
        addSubview(continueButton)
    }

    private func setupLayout() {
        stepLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(CGFloat.largePadding)
        }

        imageBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(stepLabel.snp.bottom).offset(CGFloat.largePadding)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
            make.height.equalTo(CGFloat.imageBackgroundViewHeight)
        }

        addPhotoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageBackgroundView.snp.bottom).offset(CGFloat.largePadding)
            make.height.equalTo(CGFloat.addButtonHeight)
        }

        targetTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
            make.top.equalTo(addPhotoButton.snp.bottom).offset(CGFloat.largePadding)
        }

        iconImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(CGFloat.authScaledBottomInset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
        }
    }
}
