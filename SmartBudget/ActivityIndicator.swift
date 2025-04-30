import Foundation
import UIKit

final class ActivityIndicator: UIView, ActivityIndicatorProtocol {

    private struct Constraint {
        static let lineWidth: CGFloat = 3
    }

    private var isAnimatingFlag: Bool = false
    private var circleLayer = CAShapeLayer()

    var isAnimating: Bool {
        return isAnimatingFlag
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .clear

        circleLayer.fillColor = nil
        circleLayer.strokeColor = UIColor.black.cgColor
        circleLayer.lineWidth = 3
        circleLayer.lineCap = .round
        layer.addSublayer(circleLayer)
    }

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
