import Foundation

final class CreateProfileViewModel {

    // MARK: Published Properties
    @Published private(set) var shouldShowClue: Bool = false
    
    @Published var isUploading = false
    @Published var uploadError: String?
    @Published var uploadSuccess = false

    // MARK: Properties
    private let nameRegex = "^[\\p{L}\\-'\\s]+$"
    private let minLenght = 2
    private let maxLenght = 50

    // MARK: Public Methods
    func updateValidationStatus(name: String, lastName: String, birthDate: Date?, imageData: Data) {
        guard name.count > minLenght && name.count <= maxLenght else {
            shouldShowClue = true
            return
        }
        guard lastName.count > minLenght && lastName.count <= maxLenght else {
            shouldShowClue = true
            return
        }

        guard birthDate != nil else {
            shouldShowClue = true
            return
        }

        if name.range(of: nameRegex, options: .regularExpression) != nil && lastName.range(of: nameRegex, options: .regularExpression) != nil {
            shouldShowClue = false
            uploadProfile(firstName: name, lastName: lastName, birthday: birthDate!, imageData: imageData)
        } else {
            shouldShowClue = true
        }
    }

    func hideClue() {
        shouldShowClue = false
    }
    
    private func uploadProfile(
        firstName: String,
        lastName: String,
        birthday: Date,
        imageData: Data,
        imageName: String = "avatar.jpg",
        mimeType: String = "image/jpeg"
    ) {
        isUploading = true
        uploadError = nil

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let birthdayString = dateFormatter.string(from: birthday)

        let data = RegistrationSecondStepData(
            firstName: firstName,
            lastName: lastName,
            birthday: birthdayString,
            imageData: imageData,
            imageName: imageName,
            mimeType: mimeType
        )

        NetworkService.shared.uploadSecondStep(data: data) { [weak self] result in
            DispatchQueue.main.async {
                self?.isUploading = false
                switch result {
                case .success:
                    self?.uploadSuccess = true
                case .failure(let error):
                    self?.uploadError = error.localizedDescription
                }
            }
        }
    }
}
