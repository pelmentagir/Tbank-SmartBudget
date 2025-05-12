import UIKit
import Combine

private extension CGFloat {
    static let loadingAlpha: CGFloat = 0.5
    static let defaultAlpha: CGFloat = 1
    static let withDuration: CGFloat = 0.2
    static let scaleX: CGFloat = 0.95
    static let scaleY: CGFloat = 0.95
}

final class OutlineButton: UIButton {

    // MARK: Properties
    var buttonViewModel: ButtonViewModel
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
    init(viewModel: ButtonViewModel) {
        self.buttonViewModel = viewModel
        super.init(frame: .zero)
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
        buttonViewModel.$title.sink { [weak self] title in
            self?.setTitle(title, for: .normal)
        }.store(in: &cancellables)

        buttonViewModel.$font.sink { [weak self] font in
            self?.titleLabel?.font = font
        }.store(in: &cancellables)

        buttonViewModel.$buttonState.sink { [weak self] state in
            self?.configure(state: state)
        }.store(in: &cancellables)
    }
}

// MARK: - IButton

extension OutlineButton: IButton {

    func configure(state: ButtonState) {
        switch state {
        case .normal:
            isEnabled = true
            alpha = .defaultAlpha
        default:
            isEnabled = false
            alpha = .loadingAlpha
        }
    }
}
