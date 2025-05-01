import UIKit

private extension CGFloat {
    static let lineWidth: CGFloat = 3
    static let fromValueAnimation: CGFloat = 0
    static let toValueAnimation: CGFloat = 2 * CGFloat.pi
    static let durationAnimation: CGFloat = 1.5
}

final class ActivityIndicator: UIView {

    // MARK: Properties
    private var isAnimatingFlag: Bool = false
    private var circleLayer = CAShapeLayer()

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()

        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - circleLayer.lineWidth

        let path = UIBezierPath()
        path.addArc(
            withCenter: center,
            radius: radius,
            startAngle: -.pi / 2,
            endAngle: .pi / 3,
            clockwise: true)

        circleLayer.path = path.cgPath
        circleLayer.frame = bounds
    }

    // MARK: Private methods
    private func setup() {
        backgroundColor = .clear

        circleLayer.fillColor = nil
        circleLayer.strokeColor = UIColor.black.cgColor
        circleLayer.lineWidth = .lineWidth
        circleLayer.lineCap = .round
        layer.addSublayer(circleLayer)
    }
}

// MARK: - IActivityIndicator

extension ActivityIndicator: IActivityIndicator {

    // MARK: Properties
    var isAnimating: Bool {
        return isAnimatingFlag
    }

    func startAnimating() {
        guard !isAnimatingFlag else { return }

        isAnimatingFlag = true
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = CGFloat.fromValueAnimation
        rotationAnimation.toValue = CGFloat.toValueAnimation
        rotationAnimation.duration = CGFloat.durationAnimation
        rotationAnimation.repeatCount = .infinity
        rotationAnimation.isRemovedOnCompletion = false

        circleLayer.add(rotationAnimation, forKey: "rotation")
    }

    func stopAnimating() {
        guard isAnimatingFlag else { return }
        isAnimatingFlag = false
        circleLayer.removeAllAnimations()
    }
}
