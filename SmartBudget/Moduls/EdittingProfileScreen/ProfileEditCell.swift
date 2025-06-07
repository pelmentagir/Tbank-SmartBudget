import UIKit

final class ProfileEditCell: UITableViewCell, ProfileEditCellProtocol {
    
    // MARK: UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .defaultFontSize)
        return label
    }()

    private(set) lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: .defaultFontSize)
        textField.textAlignment = .right
        textField.keyboardType = .default
        return textField
    }()

    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    func configure(title: String, placeholder: String, text: String?, keyboardType: UIKeyboardType = .default) {
        titleLabel.text = title
        textField.placeholder = placeholder
        textField.text = text
        textField.keyboardType = keyboardType
    }

    // MARK: Private Methods
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)

        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(CGFloat.largePadding)
            make.centerY.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }

        textField.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-CGFloat.largePadding)
            make.leading.equalTo(titleLabel.snp.trailing).offset(CGFloat.largePadding)
            make.centerY.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
}

// MARK: ReuseIdentifier
extension ProfileEditCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
