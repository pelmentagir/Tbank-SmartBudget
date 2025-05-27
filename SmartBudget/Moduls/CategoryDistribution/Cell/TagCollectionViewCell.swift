import UIKit

private extension CGFloat {
    static let edgesPadding: CGFloat = 6
    static let horizontalPadding: CGFloat = 8
    static let removeButtonSize: CGFloat = 12
}

final class TagCollectionViewCell: UICollectionViewCell {

    // MARK: UI Elements
    private lazy var yellowBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .customYellow2
        view.layer.cornerRadius = .cornerRadius
        return view
    }()

    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .defaultFontSize, weight: .regular)
        label.textAlignment = .left
        return label
    }()

    private(set) lazy var removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(AppIcon.xmark.image, for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(weight: .bold), forImageIn: .normal)
        button.tintColor = .systemGray
        return button
    }()

    private var removeAction: UIAction?

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCicle
    override func prepareForReuse() {
        super.prepareForReuse()

        if let action = removeAction {
            removeButton.removeAction(action, for: .touchUpInside)
            removeAction = nil
        }
    }

    // MARK: Public Methods
    func configureCell(text: String, onRemove: @escaping () -> Void) {
        infoLabel.text = text
        let action = UIAction { _ in
            onRemove()
        }
        removeButton.addAction(action, for: .touchUpInside)
        removeAction = action
    }

    // MARK: Private Methods
    private func addSubviews() {
        contentView.addSubview(yellowBackgroundView)
        yellowBackgroundView.addSubview(infoLabel)
        yellowBackgroundView.addSubview(removeButton)
    }

    private func setupLayout() {
        yellowBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().inset(CGFloat.edgesPadding)
        }

        infoLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(CGFloat.horizontalPadding)
        }

        removeButton.snp.makeConstraints { make in
            make.height.width.equalTo(CGFloat.removeButtonSize)
            make.leading.equalTo(infoLabel.snp.trailing).offset(CGFloat.horizontalPadding)
            make.trailing.equalToSuperview().offset(-CGFloat.horizontalPadding)
            make.centerY.equalToSuperview()
        }
    }
}

// MARK: - ReuseIdentifier

extension TagCollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
