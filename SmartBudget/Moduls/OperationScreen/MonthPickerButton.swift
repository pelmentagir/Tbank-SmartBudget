import UIKit
import SnapKit

private extension CGFloat {
    static var activityIndicatorSize: CGFloat = 30
    static let loadingAlpha: CGFloat = 0.5
    static let defaultAlpha: CGFloat = 1
    static let withDuration: CGFloat = 0.2
    static let scaleX: CGFloat = 0.95
    static let scaleY: CGFloat = 0.95
    static let separatorWidth: CGFloat = 3
    static let arrowPadding: CGFloat = 6
    static let heightView: CGFloat = 32
}

final class MonthPickerButton: UIButton {

    // MARK: UI Elements
    private lazy var titleLabelCustom: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.text = "Апрель"
        return label
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()

    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 6, weight: .bold)
        imageView.image = UIImage(systemName: "chevron.down", withConfiguration: config)
        imageView.tintColor = .systemBackground
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: Override Properties
    override var intrinsicContentSize: CGSize {
        let labelSize = titleLabelCustom.intrinsicContentSize
        let arrowSize = arrowImageView.intrinsicContentSize
        let totalWidth = CGFloat.mediumPadding + labelSize.width + CGFloat.smallPadding + CGFloat.separatorWidth + CGFloat.arrowPadding + arrowSize.width + CGFloat.mediumPadding

        return CGSize(width: totalWidth, height: CGFloat.heightView)
    }

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: CGFloat.withDuration, delay: .zero, options: [.allowUserInteraction, .curveEaseOut]) {
                self.alpha = self.isHighlighted ? .loadingAlpha : .defaultAlpha
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: .scaleX, y: .scaleY) : .identity
            }
        }
    }

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }

    // MARK: Public Methods
    func setTitle(_ title: String) {
        titleLabelCustom.text = title

        self.invalidateIntrinsicContentSize()
    }

    // MARK: Private Methods
    private func setupAppearance() {
        backgroundColor = .customBlue2
        layer.cornerRadius = .cornerRadius
        clipsToBounds = true
    }

    private func addSubviews() {
        addSubview(titleLabelCustom)
        addSubview(separatorView)
        addSubview(arrowImageView)
    }

    private func setupConstraints() {
        titleLabelCustom.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(CGFloat.mediumPadding)
            make.centerY.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(CGFloat.smallPadding)
        }

        separatorView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabelCustom.snp.trailing).offset(CGFloat.smallPadding)
            make.centerY.equalToSuperview()
            make.width.equalTo(CGFloat.separatorWidth)
            make.top.bottom.equalToSuperview()
        }

        arrowImageView.snp.makeConstraints { make in
            make.leading.equalTo(separatorView.snp.trailing).offset(CGFloat.arrowPadding)
            make.trailing.equalToSuperview().inset(CGFloat.mediumPadding)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(CGFloat.mediumPadding)
        }
    }
}
