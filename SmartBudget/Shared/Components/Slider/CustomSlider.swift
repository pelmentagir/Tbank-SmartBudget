import UIKit

private extension CGFloat {
    static let thumbSize: CGFloat = 20
}

class CustomSlider: UISlider {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSlider()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSlider() {
        let thumbImage = createThumbImage(size: .thumbSize)
        setThumbImage(thumbImage, for: .normal)
        setThumbImage(thumbImage, for: .highlighted)

        minimumTrackTintColor = .customYellow
    }

    private func createThumbImage(size: CGFloat) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: size, height: size))
        return renderer.image { _ in
            let rect = CGRect(x: 0, y: 0, width: size, height: size)
            let path = UIBezierPath(ovalIn: rect)
            UIColor.customYellow.setFill()
            path.fill()
        }
    }
}
