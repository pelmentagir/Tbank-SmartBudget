import UIKit

// MARK: - IButtonFactory

protocol IButtonFactory {
    func createButton(type: ButtonType, title: String, state: ButtonState, font: UIFont) -> IButton
}

final class ButtonFactory: IButtonFactory {
    func createButton(
        type: ButtonType,
        title: String,
        state: ButtonState = .normal,
        font: UIFont = .systemFont(ofSize: .defaultFontSize, weight: .regular)
    ) -> IButton {

        let button: IButton
        let buttonViewModel = ButtonViewModel(title: title, buttonState: state, font: font)
        switch type {
        case .standard:
            button = StandartButton(viewModel: buttonViewModel)
        case .outline:
            button = OutlineButton(viewModel: buttonViewModel)
        }

        return button
    }
}
