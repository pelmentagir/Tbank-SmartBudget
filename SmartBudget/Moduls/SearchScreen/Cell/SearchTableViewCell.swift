import UIKit

private extension CGFloat {
    static let backgroundIconViewSize: CGFloat = 32
    static let icomEdges: CGFloat = 5
}

final class SearchTableViewCell: UITableViewCell, SearchTableViewCellProtocol {

    // MARK: UI Elements
    private lazy var backgroundIconView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = .cornerRadius
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
    func configureCell(category: CategoryItem) {
        titleLabel.text = category.categoryName
        iconView.image = UIImage.getIconByCategory(categoryName: category.categoryName)
        backgroundIconView.backgroundColor = UIColor.getBackgroundColorByCategory(categoryName: category.categoryName).withAlphaComponent(.alphaBackgorundViewCategory)
    }

    // MARK: Private Methods
    private func addSubveiws() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(backgroundIconView)
        backgroundIconView.addSubview(iconView)
    }

    private func setupLayout() {

        backgroundIconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(CGFloat.largePadding)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(CGFloat.backgroundIconViewSize)
        }

        iconView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview().inset(CGFloat.icomEdges)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(backgroundIconView.snp.trailing).offset(CGFloat.smallPadding)
            make.trailing.equalToSuperview().inset(CGFloat.largePadding)
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
