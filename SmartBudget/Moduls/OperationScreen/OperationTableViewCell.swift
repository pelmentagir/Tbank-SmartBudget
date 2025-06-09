import UIKit

private extension CGFloat {
    static let backgroundIconViewSize: CGFloat = 42
    static let backgrounIconPadding: CGFloat = 24
    static let icomEdges: CGFloat = 5
}

final class OperationTableViewCell: UITableViewCell {

    // MARK: UI Elements
    private lazy var backgroundIconView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = .backgroundIconViewSize / 2
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

    private lazy var spendMoneyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .normalFontSize, weight: .regular)
        label.textColor = .systemGray
        return label
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
    func configureCell(category: CategoryDetailsForDay) {
        titleLabel.text = category.categoryName
        iconView.image = UIImage.getIconByCategory(categoryName: category.categoryName)
        backgroundIconView.backgroundColor = UIColor.getBackgroundColorByCategory(categoryName: category.categoryName).withAlphaComponent(.alphaBackgorundViewCategory)
        spendMoneyLabel.text = "\(category.spendMoney.formattedWithoutDecimalIfWhole()) ₽"
    }

    // MARK: Private Methods
    private func addSubveiws() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(backgroundIconView)
        contentView.addSubview(spendMoneyLabel)
        backgroundIconView.addSubview(iconView)
    }

    private func setupLayout() {

        backgroundIconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(CGFloat.backgrounIconPadding)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(CGFloat.backgroundIconViewSize)
        }

        iconView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview().inset(CGFloat.smallPadding)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(backgroundIconView.snp.trailing).offset(CGFloat.largePadding)
            make.trailing.equalTo(spendMoneyLabel.snp.leading).inset(CGFloat.largePadding)
            make.centerY.equalToSuperview()
        }

        spendMoneyLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(CGFloat.largePadding)
            make.centerY.equalToSuperview()
        }
    }
}

extension OperationTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
