import UIKit

protocol ITextFieldFactory {
    static func createTextField(type: TextFieldType, placeholder: String) -> ITextField
    static func createTextFieldView(type: TextFieldType, placeholder: String, rightButton: UIButton?) -> UIView
}

final class TextFieldFactory: ITextFieldFactory {

    static func createTextField(type: TextFieldType, placeholder: String) -> ITextField {
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
        }

        textField.placeholder = placeholder
        return textField
    }

    static func createTextFieldView(
        type: TextFieldType,
        placeholder: String,
        rightButton: UIButton? = nil
    ) -> UIView {
        let textField = createTextField(type: type, placeholder: placeholder)
        return TextFieldView(textField: textField, rightButton: rightButton)
    }
}
