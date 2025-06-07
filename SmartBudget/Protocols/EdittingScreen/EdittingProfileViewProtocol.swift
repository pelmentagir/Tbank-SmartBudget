import UIKit

protocol EdittingProfileViewProtocol: AnyObject {
    func updateLayout(keyboardRect: CGRect)
    func setupAvatar(image: UIImage)
    func showClue(_ show: Bool)
}
