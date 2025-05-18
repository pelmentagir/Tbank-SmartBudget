import UIKit

enum AppIcon {
    case eye
    case eyeSlash
    case plusCircleFill

    var image: UIImage? {
        switch self {
        case .eye:
            return UIImage(systemName: "eye")
        case .eyeSlash:
            return UIImage(systemName: "eye.slash")
        case .plusCircleFill:
            return UIImage(systemName: "plus.circle.fill")
        }
    }
}
