import Foundation

protocol IButton: AnyObject {
    var title: String? { get set }
    var buttonState: ButtonState { get set }

    func configure()
}
