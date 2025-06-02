import Foundation

enum LocaleIdentifier {
    case ru
    
    var identifier: String {
        switch self {
        case .ru:
            return "ru_RU"
        }
    }
}
