import UIKit
import TOCropViewController

enum CropType {
    case avatar
    case photo
}

final class ImagePickerCoordinator: NSObject, Coordinator {

    // MARK: Properties
    var navigationController: UINavigationController
    var appContainer: AppContainer
    var didSelectImage: ((UIImage) -> Void)?
    let cropType: CropType

    var flowCompletionHandler: (() -> Void)?

    // MARK: Initialization
    init(navigationController: UINavigationController, appContainer: AppContainer, type: CropType) {
        self.navigationController = navigationController
        self.appContainer = appContainer
        self.cropType = type
    }

    // MARK: Public Methods
    func start() {
        showImagePicker()
    }

    // MARK: Private Methods
    private func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        navigationController.present(imagePicker, animated: true)
    }

    private func showCropAvatarViewController(with image: UIImage) {
        let cropViewController = TOCropViewController(croppingStyle: .circular, image: image)
        cropViewController.delegate = self
        cropViewController.aspectRatioPreset = .presetSquare
        cropViewController.aspectRatioLockEnabled = true
        cropViewController.resetAspectRatioEnabled = false
        cropViewController.cropView.cropBoxResizeEnabled = false
        navigationController.present(cropViewController, animated: true)
    }

    private func showCropViewController(with image: UIImage) {
        let cropViewController = TOCropViewController(croppingStyle: .default, image: image)
        cropViewController.delegate = self
        cropViewController.aspectRatioPreset = .preset16x9
        cropViewController.aspectRatioLockEnabled = true
        cropViewController.resetAspectRatioEnabled = false
        cropViewController.cropView.cropBoxResizeEnabled = false
        navigationController.present(cropViewController, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension ImagePickerCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true) { [weak self] in
            if let image = info[.originalImage] as? UIImage {
                if self?.cropType == .avatar {
                    self?.showCropAvatarViewController(with: image)
                } else {
                    self?.showCropViewController(with: image)
                }
            }
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

// MARK: - TOCropViewControllerDelegate

extension ImagePickerCoordinator: TOCropViewControllerDelegate {
    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        didSelectImage?(image)
        cropViewController.dismiss(animated: true)
    }

    func cropViewControllerDidCancel(_ cropViewController: TOCropViewController) {
        cropViewController.dismiss(animated: true)
    }
}
