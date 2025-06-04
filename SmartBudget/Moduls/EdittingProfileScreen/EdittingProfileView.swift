import UIKit

private extension String {
    static let clueText = "Допустимы буквы, дефисы и апострофы \n (2–50 символов)"
    static let saveButtonText = "Сохранить"
}

private extension CGFloat {
    static let avatarImageTopPadding: CGFloat = 20
    static let avatarImageSize: CGFloat = 140
    static let rowHeight: CGFloat = 44
}

final class EdittingProfileView: UIView {

    // MARK: Properties
    private var buttonFactory: ButtonFactory
    private var textFieldFactory: TextFieldFactory

    // MARK: UI Elements
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.IMG_4382
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray6
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat.avatarImageSize / 2
        return imageView
    }()

    private(set) lazy var choosePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выбрать фотографию", for: .normal)
        return button
    }()

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .secondarySystemBackground
        tableView.separatorStyle = .singleLine
        tableView.isScrollEnabled = false
        tableView.rowHeight = .rowHeight
        tableView.register(ProfileEditCell.self, forCellReuseIdentifier: ProfileEditCell.reuseIdentifier)
        return tableView
    }()

    private(set) lazy var saveButton: IButton = buttonFactory.createButton(type: .standard, title: .saveButtonText)

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

    // MARK: Initialization
    init(buttonFactory: ButtonFactory, textFieldFactory: TextFieldFactory) {
        self.buttonFactory = buttonFactory
        self.textFieldFactory = textFieldFactory
        super.init(frame: .zero)
        backgroundColor = .secondarySystemBackground
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
        addSubview(choosePhotoButton)
        addSubview(tableView)
        addSubview(saveButton)
        addSubview(clueLabel)
    }

    private func setupLayout() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(CGFloat.avatarImageTopPadding)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGFloat.avatarImageSize)
        }

        choosePhotoButton.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(CGFloat.mediumPadding)
            make.centerX.equalToSuperview()
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(choosePhotoButton.snp.bottom).offset(CGFloat.smallPadding)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(clueLabel.snp.top).offset(-CGFloat.largePadding)
        }

        clueLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.authScaledHorizontalInset)
            make.bottom.equalTo(saveButton.snp.top).offset(-CGFloat.profileClueBottomOffset)
        }

        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(CGFloat.authScaledBottomInset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
        }
    }
}
