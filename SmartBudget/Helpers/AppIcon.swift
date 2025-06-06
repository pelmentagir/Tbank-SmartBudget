import UIKit

enum AppIcon {
    case eye
    case eyeSlash
    case plusCircleFill
    case xmark
    case plusCircle
    case squareFill
    case checkmarkSquareFill

    var image: UIImage? {
        switch self {
        case .eye:
            return UIImage(systemName: "eye")
        case .eyeSlash:
            return UIImage(systemName: "eye.slash")
        case .plusCircleFill:
            return UIImage(systemName: "plus.circle.fill")
        case .xmark:
            return UIImage(systemName: "xmark")
        case .plusCircle:
            return UIImage(systemName: "plus.circle")
        case .squareFill:
            return UIImage(systemName: "square.fill")
        case .checkmarkSquareFill:
            return UIImage(systemName: "checkmark.square.fill")
        }
    }
}
