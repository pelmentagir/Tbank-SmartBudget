import UIKit

protocol ITextFieldFactory {
    func createTextFieldView(type: TextFieldType, placeholder: String, rightButton: UIButton?) -> TextFieldView
}

final class TextFieldFactory: ITextFieldFactory {

    private func createTextField(type: TextFieldType, placeholder: String) -> ITextField {
        let textField: ITextField
        switch type {
        case .default:
            textField = DefaultTextField()
        case .email:
            textField = EmailTextField()
        case .password:
            textField = PasswordTextField()
        case .numeric:
            textField = NumericTextField()
        case .code:
            textField = CodeTextField()
        }

        textField.placeholder = placeholder
        return textField
    }

    func createTextFieldView(
        type: TextFieldType,
        placeholder: String,
        rightButton: UIButton? = nil
    ) -> TextFieldView {
        let textField = createTextField(type: type, placeholder: placeholder)
        return TextFieldView(textField: textField, rightButton: rightButton)
    }
}
