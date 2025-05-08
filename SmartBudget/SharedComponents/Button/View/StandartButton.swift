import UIKit
import Combine

private extension CGFloat {
    static let baseHeight: CGFloat = 56
    static var scaledHeight: CGFloat = baseHeight * (screenWidth / baseWidth)
    static var activityIndicatorSize: CGFloat = 30
    static let loadingAlpha: CGFloat = 0.5
    static let defaultAlpha: CGFloat = 1
    static let withDuration: CGFloat = 0.2
    static let scaleX: CGFloat = 0.95
    static let scaleY: CGFloat = 0.95
}

final class StandartButton: UIButton {

    // MARK: Properties
    private var _buttonViewModel = ButtonViewModel(title: "")
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
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        setupLayout()
        setupBindings()
    }

    private func setupLayout() {
        snp.makeConstraints { make in
            make.height.equalTo(CGFloat.scaledHeight)
        }
    }

    private func setupBindings() {
        _buttonViewModel.$title
            .receive(on: DispatchQueue.main)
            .sink { [weak self] title in
                self?.setTitle(title, for: .normal)
            }
            .store(in: &cancellables)

        _buttonViewModel.$buttonState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                print("Button state changed to: \(state)")
                self?.configure()
            }
            .store(in: &cancellables)

        _buttonViewModel.$font
            .receive(on: DispatchQueue.main)
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

    // MARK: Properties
    var buttonViewModel: ButtonViewModel {
        get { _buttonViewModel }
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
