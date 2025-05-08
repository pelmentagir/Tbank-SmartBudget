import UIKit

// MARK: - IButtonFactory

protocol IButtonFactory {
    func createButton(type: ButtonType, title: String, state: ButtonState, font: UIFont) -> IButton
}

class ButtonFactory: IButtonFactory {
    func createButton(
        type: ButtonType,
        title: String,
        state: ButtonState = .normal,
        font: UIFont = .systemFont(ofSize: 16, weight: .regular)
    ) -> IButton {

        let button: IButton

        switch type {
        case .standard:
            button = StandartButton()
        case .outline:
            button = OutlineButton()
        }

        button.buttonViewModel = ButtonViewModel(title: title, buttonState: state, font: font)

        return button
    }
}
