import UIKit

private extension TimeInterval {
    static let defaultTime = 0.3
}

private extension CGFloat {
    static let backgroundAlpha: CGFloat = 0.35
}

final class CustomHeightPresentationController: UIPresentationController {

    // MARK: Properties
    private let customHeight: CGFloat

    // MARK: UI Elements
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(.backgroundAlpha)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
        view.addGestureRecognizer(tapGesture)
        return view
    }()

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView else { return .zero }

        let height = min(customHeight, containerView.bounds.height)
        return CGRect(x: 0,
                      y: containerView.bounds.height - height,
                      width: containerView.bounds.width,
                      height: height)
    }

    // MARK: Initialization
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, customHeigth: CGFloat) {
        self.customHeight = customHeigth
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }

    // MARK: UIPresentationController Methods
    override func presentationTransitionWillBegin() {
        setup()
        backgroundView.alpha = 0

        presentedView?.layer.cornerRadius = .cornerRadius
        presentedView?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        presentedView?.clipsToBounds = true

        UIView.animate(withDuration: .defaultTime) {
            self.backgroundView.alpha = 1
        }
    }

    override func dismissalTransitionWillBegin() {
        UIView.animate(withDuration: .defaultTime) {
            self.backgroundView.alpha = 0
        } completion: { _ in
            self.backgroundView.removeFromSuperview()
        }
    }

    // MARK: Private Methods
    @objc private func handleBackgroundTap() {
        presentedViewController.dismiss(animated: true)
    }
    
    private func setup() {
        setupSubviews()
        setupLayout()
    }

    private func setupSubviews() {
        containerView?.addSubview(backgroundView)
    }

    private func setupLayout() {
        guard let containerView = containerView else { return }
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
    }
}
