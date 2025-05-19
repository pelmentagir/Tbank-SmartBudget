import UIKit
import Combine

final class RegistrationViewController: UIViewController, FlowController {

    private var registrationView: RegistrationView {
        self.view as! RegistrationView
    }

    // MARK: Properties
    private let viewModel: RegistrationViewModel
    private var authTextFieldDelegate: AuthTextFieldDelegate?
    private var keyboardObserver: KeyboardObserver?
    var completionHandler: ((User?) -> Void)?
    private var cancellables = Set<AnyCancellable>()

    private lazy var registrationButtonTapped = UIAction { [weak self] _ in
        guard let self else { return }
        viewModel.registrationUser(login: registrationView.loginTextField.textField.text!, password: registrationView.passwordTextField.textField.text!)
    }

    // MARK: Initialization
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.view = RegistrationView(textFieldFactory: TextFieldFactory(), buttonFactory: ButtonFactory())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        setupBindings()
        setupKeyboardObserver()
        setupAction()
    }

    // MARK: Private Methods
    private func setupTextFields() {
        authTextFieldDelegate = AuthTextFieldDelegate()
        authTextFieldDelegate!.setEmailTextField(registrationView.loginTextField.textField)
        authTextFieldDelegate!.setPasswordTextField(registrationView.passwordTextField.textField)
        authTextFieldDelegate!.setConfirmPasswordTextField(registrationView.passwordConfirmTextField.textField)

        authTextFieldDelegate?.checkPasswords = { [weak self] password in
            guard let self else { return }
            let valid = viewModel.isPasswordValid(with: password, confirmText: registrationView.passwordTextField.textField.text!)
            registrationView.visableClue(valid)
        }
    }

    private func setupBindings() {
        viewModel.$isRegistration
            .dropFirst()
            .sink { [weak self] isRegistration in
                self?.registrationView.registrationButton.buttonViewModel.buttonState = isRegistration ? .loading : .normal
            }.store(in: &cancellables)

        viewModel.$user
            .compactMap { $0 }
            .sink { [weak self] user in
                self?.completionHandler?(user)
            }.store(in: &cancellables)

        authTextFieldDelegate?.$active
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] isActive in
                self?.registrationView.registrationButton.buttonViewModel.buttonState = isActive ? .normal : .disabled
            }
            .store(in: &cancellables)
    }

    private func setupKeyboardObserver() {
        keyboardObserver = KeyboardObserver(onShow: { [weak self] keyboardFrame in
            guard let self else { return }

            registrationView.updateLayout(keyboardRect: keyboardFrame)
        }, onHide: { [weak self] in
            guard let self else { return }
            registrationView.updateLayout()
        })
    }

    private func setupAction() {
        registrationView.registrationButton.addAction(registrationButtonTapped, for: .touchUpInside)
    }
}
