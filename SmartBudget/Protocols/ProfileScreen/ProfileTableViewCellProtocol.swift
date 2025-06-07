import UIKit

protocol ProfileTableViewCellProtocol: AnyObject {
    func configure(title: String, value: String, showToggle: Bool, toggleAction: UIAction?)
}
