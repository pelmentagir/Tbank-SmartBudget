import UIKit
import Combine

// MARK: - IButton

protocol IButton: UIButton {
    var buttonViewModel: ButtonViewModel { get set }

    func configure(state: ButtonState)
}

// MARK: - Model

final class ButtonViewModel: ObservableObject {
    @Published var title: String
    @Published var buttonState: ButtonState
    @Published var font: UIFont

    init(
        title: String,
        buttonState: ButtonState = .normal,
        font: UIFont = .systemFont(ofSize: .defaultFontSize, weight: .regular)
    ) {
        self.title = title
        self.buttonState = buttonState
        self.font = font
    }
}

// MARK: - Enum

enum ButtonState {
    case normal
    case disabled
    case loading
}

enum ButtonType {
    case standard
    case outline
}
