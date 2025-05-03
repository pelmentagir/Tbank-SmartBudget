import UIKit

protocol ITextField: UITextField {
    var isValid: Bool { get }
}

enum TextFieldType {
    case `default`
    case email
    case password
    case numeric
}
