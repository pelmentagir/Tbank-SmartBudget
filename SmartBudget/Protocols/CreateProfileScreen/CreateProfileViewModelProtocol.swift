import Combine
import Foundation

protocol CreateProfileViewModelProtocol: AnyObject {
    // MARK: Published Properties
    var shouldShowClue: Bool { get }
    var isUploading: Bool { get }
    var uploadError: String? { get }
    var uploadSuccess: Bool { get }

    var shouldShowCluePublisher: Published<Bool>.Publisher { get }
    var isUploadingPublisher: Published<Bool>.Publisher { get }
    var uploadErrorPublisher: Published<String?>.Publisher { get }
    var uploadSuccessPublisher: Published<Bool>.Publisher { get }

    // MARK: Methods
    func updateValidationStatus(name: String, lastName: String, birthDate: Date?, imageData: Data)
    func hideClue()
}

extension CreateProfileViewModel: CreateProfileViewModelProtocol {
    var shouldShowCluePublisher: Published<Bool>.Publisher { $shouldShowClue }
    var isUploadingPublisher: Published<Bool>.Publisher { $isUploading }
    var uploadErrorPublisher: Published<String?>.Publisher { $uploadError }
    var uploadSuccessPublisher: Published<Bool>.Publisher { $uploadSuccess }
}
