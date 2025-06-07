import UIKit
protocol EdittingProfileViewControllerProtocol: FlowController {
    // MARK: - Public Properties
    var presentImagePicker: (() -> Void)? { get set }

    // MARK: - Public Methods
    func handleAvatarImage(image: UIImage)
}
