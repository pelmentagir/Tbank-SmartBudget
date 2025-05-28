import UIKit
import TOCropViewController
import Combine

final class CreateProfileViewController: UIViewController, FlowController {

    private var createProfileView: CreateProfileView {
        self.view as! CreateProfileView
    }

    // MARK: Properties
    var completionHandler: ((User) -> Void)?
    var presentImagePicker: (() -> Void)?
    private var viewModel: CreateProfileViewModelProtocol
    private var keyboardObserver: KeyboardObserver?
    private var textFieldDelegate: FullNameTextFieldDelegate?
    private var cancellable = Set<AnyCancellable>()

    private lazy var selectImageButtonTapped = UIAction { [weak self] _ in
        guard let self else { return }
        presentImagePicker?()
    }

    private lazy var continueButtonTapped = UIAction { [weak self] _ in
        guard let self else { return }
        viewModel.updateValidationStatus(name: createProfileView.nameTextField.getField().text!, lastName: createProfileView.lastNameTextField.getField().text!)
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

        viewModel.isValidPublisher
            .removeDuplicates()
            .sink { [weak self] valid in
                if valid {
                    self?.completionHandler?(User(name: "", lastName: "", login: "", password: ""))
                }
            }.store(in: &cancellable)

        viewModel.shouldShowCluePublisher
            .removeDuplicates()
            .sink { [weak self] show in
                self?.createProfileView.showClue(!show)
            }.store(in: &cancellable)
    }
}
