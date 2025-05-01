import UIKit

extension CGFloat {
    static let baseWidth: CGFloat = 390 // средняя ширина iphone 12-16/pro
    static let baseHeight: CGFloat = 56
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static var scaledHeight: CGFloat = baseHeight * (screenWidth / baseWidth)
    static let fontSize: CGFloat = 16
    static let cornerRadius: CGFloat = 16
    static let loadingAlpha: CGFloat = 0.5
    static let defaultAlpha: CGFloat = 1
}

final class StandartButton: UIButton {
    
    // MARK: Properties
    private var _title: String?
    private var _buttonState: ButtonState = .normal
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private methods
    private func setup() {
        backgroundColor = .systemYellow
        layer.cornerRadius = .cornerRadius
        titleLabel?.font = .systemFont(ofSize: .fontSize, weight: .regular)
        setTitleColor(.black, for: .normal)
        setupLayout()
    }

    private func setupLayout() {
        snp.makeConstraints { make in
            make.height.equalTo(CGFloat.scaledHeight)
        }
    }
}

// MARK: - IButton

extension StandartButton: IButton {
    
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

    var buttonState: ButtonState {
        get { _buttonState }
        set {
            _buttonState = newValue
            configure()
        }
    }

    var font: UIFont? {
        get { titleLabel?.font }
        set { titleLabel?.font = newValue }
    }
    
    func configure() {
        switch buttonState {
        case .normal:
            isEnabled = true
            alpha = .defaultAlpha
            setTitle(title, for: .normal)
        case .disabled:
            isEnabled = false
            alpha = .loadingAlpha
            setTitle(title, for: .normal)
        case .loading:
            isEnabled = false
            alpha = .defaultAlpha
            setTitle(nil, for: .normal)
        }
    }
}
