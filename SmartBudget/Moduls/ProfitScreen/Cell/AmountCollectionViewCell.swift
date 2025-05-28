import UIKit

private extension String {
    static let currencyText = "₽"
}

private extension CGFloat {
    static let spacing: CGFloat = 2
}

final class AmountCollectionViewCell: UICollectionViewCell {

    // MARK: UI Elements
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .normalFontSize, weight: .medium)
        label.textAlignment = .right
        return label
    }()

    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.text = .currencyText
        label.font = .systemFont(ofSize: .normalFontSize, weight: .bold)
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

    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    func configureCell(amount: Int) {
        amountLabel.text = "\(amount) "
    }

    // MARK: Private Methods
    private func updateAppearance() {
        UIView.animate(withDuration: 0.2) {
            self.yellowViewBackground.backgroundColor = self.isSelected ? .customYellow : .customYellow2
        }
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
