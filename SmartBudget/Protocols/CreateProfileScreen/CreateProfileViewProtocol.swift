import UIKit

protocol CreateProfileViewProtocol: AnyObject {
    func updateLayout(keyboardRect: CGRect)
    func setupAvatar(image: UIImage)
    func showClue(_ show: Bool)
}
