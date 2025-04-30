import Foundation
import UIKit

// MARK: - Constants
private extension CGFloat {
    static let lineWidth: CGFloat = 3
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

    // MARK: Layout
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
        circleLayer.lineWidth = 3
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

    // MARK: Animation
    func startAnimating() {
        guard !isAnimatingFlag else { return }

        isAnimatingFlag = true
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = 2 * CGFloat.pi
        rotationAnimation.duration = 1.5
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
