import UIKit

private extension CGFloat {
    static let backgroundIconViewSize: CGFloat = 32
    static let horizontalPadding: CGFloat = 16
    static let titleLeadingPadding: CGFloat = 8
    static let icomEdges: CGFloat = 5
    static let backgroundIconViewCornerRadius: CGFloat = 16
}

final class SearchTableViewCell: UITableViewCell {

    // MARK: UI Elements
    private lazy var backgroundIconView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = .backgroundIconViewCornerRadius
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .defaultFontSize, weight: .regular)
        return label
    }()

    private lazy var iconView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()

    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubveiws()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    func configureCell(category: Category) {
        titleLabel.text = category.name
        iconView.image = category.icon
        backgroundIconView.backgroundColor = category.backgroundColor.withAlphaComponent(.alphaBackgorundViewCategory)
    }

    // MARK: Private Methods
    private func addSubveiws() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(backgroundIconView)
        backgroundIconView.addSubview(iconView)
    }

    private func setupLayout() {

        backgroundIconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(CGFloat.horizontalPadding)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(CGFloat.backgroundIconViewSize)
        }

        iconView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview().inset(CGFloat.icomEdges)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(backgroundIconView.snp.trailing).offset(CGFloat.titleLeadingPadding)
            make.trailing.equalToSuperview().inset(CGFloat.horizontalPadding)
            make.centerY.equalToSuperview()
        }
    }
}

// MARK: - ReuseIdentifier

extension SearchTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
