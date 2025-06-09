import UIKit
import TOCropViewController
import Combine

final class CreateProfileViewController: UIViewController, FlowController, CreateProfileViewControllerProtocol {

    private var createProfileView: CreateProfileView {
        self.view as! CreateProfileView
    }

    // MARK: Properties
    var completionHandler: ((Bool) -> Void)?
    var presentImagePicker: (() -> Void)?
    private var viewModel: CreateProfileViewModelProtocol
    private var keyboardObserver: KeyboardObserver?
    private var textFieldDelegate: FullNameTextFieldDelegate?
    private var dateOfBirthDelegate: DateOfBirthTextFieldDelegate?
    private var cancellable = Set<AnyCancellable>()
    private var selectedImageData: Data?

    private lazy var selectImageButtonTapped = UIAction { [weak self] _ in
        guard let self else { return }
        presentImagePicker?()
    }

    private lazy var continueButtonTapped = UIAction { [weak self] _ in
        guard let self else { return }
        guard let imageData = selectedImageData else {
            return
        }
        viewModel.updateValidationStatus(
            name: createProfileView.nameTextField.getField().text!,
            lastName: createProfileView.lastNameTextField.getField().text!,
            birthDate: dateOfBirthDelegate?.getSelectedDate(),
            imageData: imageData
        )
    }

    // MARK: Initialization
    init(viewModel: CreateProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: LifeCicle
    override func loadView() {
        self.view = CreateProfileView(buttonFactory: ButtonFactory(), textFieldFactory: TextFieldFactory())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAction()
        setupBindings()
        configureTextField()
        setupKeyboardObserver()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    func handleAvatarImage(image: UIImage) {
        createProfileView.setupAvatar(image: image)
        selectedImageData = image.jpegData(compressionQuality: 0.8)
    }

    // MARK: Private Methods
    private func setupAction() {
        createProfileView.addAvatarButton.addAction(selectImageButtonTapped, for: .touchUpInside)
        createProfileView.continueButton.addAction(continueButtonTapped, for: .touchUpInside)
    }

    private func configureTextField() {
        textFieldDelegate = FullNameTextFieldDelegate()
        textFieldDelegate?.viewModel = viewModel
        textFieldDelegate?.setNameTextField(createProfileView.nameTextField.getField())
        textFieldDelegate?.setLastNameTextField(createProfileView.lastNameTextField.getField())

        dateOfBirthDelegate = DateOfBirthTextFieldDelegate()
        dateOfBirthDelegate?.viewModel = viewModel
        dateOfBirthDelegate?.setDateOfBirthTextField(createProfileView.dateOfBirthTextField.getField())
    }

    private func setupKeyboardObserver() {
        keyboardObserver = KeyboardObserver(onShow: { [weak self] keyboardFrame in
            guard let self else { return }
            createProfileView.updateLayout(keyboardRect: keyboardFrame)
        }, onHide: { [weak self] in
            guard let self else { return }
            createProfileView.updateLayout()
        })
    }

    private func setupBindings() {

        viewModel.shouldShowCluePublisher
            .removeDuplicates()
            .sink { [weak self] show in
                self?.createProfileView.showClue(!show)
            }.store(in: &cancellable)
            
        viewModel.isUploadingPublisher
            .sink { [weak self] isUploading in
                self?.createProfileView.continueButton.isEnabled = !isUploading
                
                if isUploading {
                    self?.completionHandler?(true)
                }
            }.store(in: &cancellable)
            
        viewModel.uploadErrorPublisher
            .compactMap { $0 }
            .sink { [weak self] error in
              
                let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }.store(in: &cancellable)
    }
}

// MARK: - UITextFieldDelegate
extension CreateProfileViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField === createProfileView.dateOfBirthTextField.getField() {
            viewModel.hideClue()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField === createProfileView.dateOfBirthTextField.getField() {
            return false
        }
        return true
    }
}
