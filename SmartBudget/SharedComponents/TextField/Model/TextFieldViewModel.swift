import UIKit

protocol ITextField: UITextField {
    var isValid: Bool { get }
    var fieldPlaceholder: String { get set }
}

enum TextFieldType {
    case `default`
    case email
    case password
    case numeric
}
