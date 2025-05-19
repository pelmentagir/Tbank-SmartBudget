import UIKit

private extension String {
    static let currencyText = "₽"
}

private extension CGFloat {
    static let spacing: CGFloat = 2
    static let fontSize: CGFloat = 14
}

class AmountCollectionViewCell: UICollectionViewCell {

    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .fontSize, weight: .medium)
        label.textAlignment = .right
        return label
    }()

    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.text = .currencyText
        label.font = .systemFont(ofSize: .fontSize, weight: .bold)
        return label
    }()

    private lazy var yellowViewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .customYellow2
        view.layer.cornerRadius = .cornerRadius
        return view
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [amountLabel, currencyLabel])
        stackView.axis = .horizontal
        stackView.spacing = .spacing
        stackView.alignment = .center
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(amount: Int) {
        amountLabel.text = "\(amount) "
    }

    private func addSubviews() {
        contentView.addSubview(yellowViewBackground)
        yellowViewBackground.addSubview(stackView)
    }

    private func setupLayout() {
        yellowViewBackground.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

extension AmountCollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
