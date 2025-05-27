import UIKit

private extension CGFloat {
    static let circleSize: CGFloat = 80
    static let edgesPadding: CGFloat = 16
    static let circleBacgroundCornerRadius: CGFloat = 40
}

final class CategoryCollectionViewCell: UICollectionViewCell {

    // MARK: UI Elements
    private lazy var circleBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = .circleBacgroundCornerRadius
        return view
    }()

    private lazy var iconCategory: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()

    private lazy var titleCategory: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: .defaultFontSize, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    func configureCell(category: Category) {
        titleCategory.text = category.name
        iconCategory.image = category.icon
        circleBackground.backgroundColor = category.backgroundColor.withAlphaComponent(.alphaBackgorundViewCategory)
    }

    // MARK: Private Methods
    private func addSubviews() {
        contentView.addSubview(circleBackground)
        circleBackground.addSubview(iconCategory)

        contentView.addSubview(titleCategory)
    }

    private func setupLayout() {
        circleBackground.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.height.width.equalTo(CGFloat.circleSize)
        }

        iconCategory.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview().inset(CGFloat.edgesPadding)
        }

        titleCategory.snp.makeConstraints { make in
            make.top.equalTo(circleBackground.snp.bottom).offset(CGFloat.edgesPadding)
            make.trailing.leading.equalToSuperview()
        }
    }
}

// MARK: - ReuseIdentifier

extension CategoryCollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
