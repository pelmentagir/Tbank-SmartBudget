import UIKit

protocol CreateProfileViewControllerProtocol: AnyObject {
    var presentImagePicker: (() -> Void)? { get set }
    func handleAvatarImage(image: UIImage)
}
