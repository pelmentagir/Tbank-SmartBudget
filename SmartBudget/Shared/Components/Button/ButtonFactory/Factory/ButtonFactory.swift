import UIKit

// MARK: - IButtonFactory

protocol IButtonFactory {
    func createButton(type: ButtonType, title: String, state: ButtonState, font: UIFont, height: CGFloat) -> IButton
}

final class ButtonFactory: IButtonFactory {
    func createButton(
        type: ButtonType,
        title: String,
        state: ButtonState = .normal,
        font: UIFont = .systemFont(ofSize: .defaultFontSize, weight: .regular),
        height: CGFloat = .baseHeight
    ) -> IButton {

        let button: IButton
        let buttonViewModel = ButtonViewModel(title: title, buttonState: state, font: font)
        switch type {
        case .standard:
            button = StandartButton(viewModel: buttonViewModel, height: height)
        case .outline:
            button = OutlineButton(viewModel: buttonViewModel)
        }

        return button
    }
}
