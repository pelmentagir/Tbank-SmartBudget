import UIKit

class MainButton: UIButton, IButton {

    private struct Constants {
        static let baseWidth: CGFloat = 390 // средняя ширина iphone 12-16/pro
        static let baseHeight: CGFloat = 56
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static var scaledHeight: CGFloat = baseHeight * (screenWidth / baseWidth)
        static let fontSize: CGFloat = 16
        static let cornerRadius: CGFloat = 16
        static let loadingAlpha: CGFloat = 0.5
        static let defaultAlpha: CGFloat = 1
    }

    private var _title: String?

    var title: String? {
        get {
            _title
        }
        set {
            _title = newValue
            if buttonState != .loading {
                setTitle(_title, for: .normal)
            }
        }
    }

    var buttonState: ButtonState = .normal {
        didSet {
            configure()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .systemYellow
        layer.cornerRadius = Constants.cornerRadius
        titleLabel?.font = .systemFont(ofSize: Constants.fontSize, weight: .regular)
        setTitleColor(.black, for: .normal)
        setupLayout()
    }

    private func setupLayout() {
        snp.makeConstraints { make in
            make.height.equalTo(Constants.scaledHeight)
        }
    }

    func configure() {
        switch buttonState {
        case .normal:
            isEnabled = true
            alpha = Constants.defaultAlpha
            setTitle(title, for: .normal)
        case .disabled:
            isEnabled = false
            alpha = Constants.loadingAlpha
            setTitle(title, for: .normal)
        case .loading:
            isEnabled = false
            alpha = Constants.defaultAlpha
            setTitle(nil, for: .normal)
        }
    }
}
