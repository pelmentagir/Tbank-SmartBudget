import UIKit

protocol IButton: AnyObject {
    var title: String? { get set }
    var buttonState: ButtonState { get set }
    var font: UIFont? { get set }

    func configure()
}
