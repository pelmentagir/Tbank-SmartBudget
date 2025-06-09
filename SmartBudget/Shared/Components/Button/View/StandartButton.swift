import UIKit
import Combine

private extension CGFloat {
    static var activityIndicatorSize: CGFloat = 30
    static let loadingAlpha: CGFloat = 0.5
    static let defaultAlpha: CGFloat = 1
    static let withDuration: CGFloat = 0.2
    static let scaleX: CGFloat = 0.95
    static let scaleY: CGFloat = 0.95
}

final class StandartButton: UIButton {

    // MARK: Properties
    var buttonViewModel: ButtonViewModel
    let baseHeight: CGFloat

    private lazy var activityIndicator: ActivityIndicator = {
        let activity = ActivityIndicator()
        return activity
    }()

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: CGFloat.withDuration, delay: .zero, options: [.allowUserInteraction, .curveEaseOut]) {
                self.alpha = self.isHighlighted ? .loadingAlpha : .defaultAlpha
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: .scaleX, y: .scaleY) : .identity
            }
        }
    }

    private var cancellables = Set<AnyCancellable>()

    // MARK: Initialization
    init(viewModel: ButtonViewModel, height: CGFloat = .baseHeight) {
        self.buttonViewModel = viewModel
        self.baseHeight = height
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private methods
    private func setup() {
        backgroundColor = .customYellow
        layer.cornerRadius = .cornerRadius
        setTitleColor(.black, for: .normal)
        setupBindings()
        setupLayout()
    }

    private func setupLayout() {
        snp.makeConstraints { make in
            make.height.equalTo(baseHeight * (CGFloat.screenWidth / CGFloat.baseWidth))
        }
    }

    private func setupBindings() {
        buttonViewModel.$title
            .sink { [weak self] title in
                self?.setTitle(title, for: .normal)
            }
            .store(in: &cancellables)

        buttonViewModel.$buttonState
            .sink { [weak self] state in
                self?.configure(state: state)
            }
            .store(in: &cancellables)

        buttonViewModel.$font
            .sink { [weak self] font in
                self?.titleLabel?.font = font
            }
            .store(in: &cancellables)
    }

    private func setupActivityIndicator() {
        addSubview(activityIndicator)

        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGFloat.activityIndicatorSize)
        }

        activityIndicator.startAnimating()
    }

    private func removeActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}

// MARK: - IButton

extension StandartButton: IButton {

    func configure(state: ButtonState) {
        switch state {
        case .normal:
            isEnabled = true
            alpha = .defaultAlpha
            setTitle(buttonViewModel.title, for: .normal)
            removeActivityIndicator()
        case .disabled:
            isEnabled = false
            alpha = .loadingAlpha
            setTitle(buttonViewModel.title, for: .normal)
            removeActivityIndicator()
        case .loading:
            isEnabled = false
            alpha = .defaultAlpha
            setTitle(nil, for: .normal)
            setupActivityIndicator()
        }
    }
}
