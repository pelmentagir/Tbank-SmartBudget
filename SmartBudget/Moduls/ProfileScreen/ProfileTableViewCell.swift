import UIKit
import SnapKit

final class ProfileTableViewCell: UITableViewCell {

    // MARK: UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .defaultFontSize, weight: .medium)
        label.textColor = .label
        return label
    }()

    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .defaultFontSize, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()

    private lazy var toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.isHidden = true
        return toggle
    }()

    // MARK: - Constraints
    private var valueLabelTrailingConstraint: Constraint?

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .systemBackground
        addSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    func configure(title: String, value: String, showToggle: Bool = false, toggleAction: UIAction? = nil) {
        titleLabel.text = title
        valueLabel.text = value
        toggleSwitch.isHidden = !showToggle

        if showToggle {
            valueLabelTrailingConstraint?.update(offset: -CGFloat.smallPadding)
        } else {
            valueLabelTrailingConstraint?.update(offset: -CGFloat.largePadding)
        }

        if let action = toggleAction {
            toggleSwitch.addAction(action, for: .valueChanged)
        }
    }

    // MARK: Private Methods
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        contentView.addSubview(toggleSwitch)
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(CGFloat.largePadding)
            make.centerY.equalToSuperview()
        }

        valueLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(CGFloat.extraLargePadding)
            make.centerY.equalToSuperview()

            self.valueLabelTrailingConstraint = make.trailing.equalToSuperview().inset(CGFloat.largePadding).constraint
        }

        toggleSwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(CGFloat.largePadding)
            make.centerY.equalToSuperview()
        }
    }
}

extension ProfileTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
