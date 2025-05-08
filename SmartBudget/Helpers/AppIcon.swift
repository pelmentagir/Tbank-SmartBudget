import UIKit

enum AppIcon {
    case eye
    case eyeSlash

    var image: UIImage? {
        switch self {
        case .eye:
            return UIImage(systemName: "eye")
        case .eyeSlash:
            return UIImage(systemName: "eye.slash")
        }
    }
}
