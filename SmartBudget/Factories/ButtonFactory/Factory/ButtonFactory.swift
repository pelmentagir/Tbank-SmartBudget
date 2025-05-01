import UIKit

class ButtonFactory: IButtonFactory {
    func createButton(
        type: ButtonType,
        title: String,
        state: ButtonState = .normal,
        font: UIFont = .systemFont(ofSize: 16, weight: .regular) // TODO: FontManager с кастомным шрифтом
    ) -> any IButton {

        let button: IButton

        switch type {
        case .standart:
            button = StandartButton()
        case .outline:
            button = StandartButton() // пока что так
        }

        button.title = title
        button.font = font
        button.buttonState = state

        return button
    }
}
