import UIKit
import Combine

private extension CGFloat {
    static let loadingAlpha: CGFloat = 0.5
    static let defaultAlpha: CGFloat = 1
    static let withDuration: CGFloat = 0.2
    static let scaleX: CGFloat = 0.95
    static let scaleY: CGFloat = 0.95
}

class OutlineButton: UIButton {

    // MARK: Properties
    private var _buttonViewModel: ButtonViewModel = ButtonViewModel(title: "")
    private var cancellables = Set<AnyCancellable>()

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
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    private func setup() {
        backgroundColor = .clear
        setTitleColor(.systemBlue, for: .normal)
        setupBindings()
    }

    private func setupBindings() {
        _buttonViewModel.$title.sink { [weak self] title in
            self?.setTitle(title, for: .normal)
        }.store(in: &cancellables)

        _buttonViewModel.$font.sink { [weak self] font in
            self?.titleLabel?.font = font
        }.store(in: &cancellables)

        _buttonViewModel.$buttonState.sink { [weak self] _ in
            self?.configure()
        }.store(in: &cancellables)
    }
}

// MARK: - IButton

extension OutlineButton: IButton {
    var buttonViewModel: ButtonViewModel {
        get {
            _buttonViewModel
        }
        set {
            _buttonViewModel = newValue
            setTitle(newValue.title, for: .normal)
            configure()
            titleLabel?.font = newValue.font
        }
    }

    func configure() {
        switch buttonViewModel.buttonState {
        case .normal:
            isEnabled = true
            alpha = .defaultAlpha
        default:
            isEnabled = false
            alpha = .loadingAlpha
        }
    }
}
