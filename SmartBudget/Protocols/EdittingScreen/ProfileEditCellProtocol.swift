import UIKit

protocol ProfileEditCellProtocol: AnyObject {
    // MARK: Public Methods
    func configure(title: String, placeholder: String, text: String?, keyboardType: UIKeyboardType)
}
