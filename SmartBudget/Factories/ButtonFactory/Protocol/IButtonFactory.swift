import UIKit

protocol IButtonFactory {
    func createButton(type: ButtonType, title: String, state: ButtonState, font: UIFont) -> IButton
}
