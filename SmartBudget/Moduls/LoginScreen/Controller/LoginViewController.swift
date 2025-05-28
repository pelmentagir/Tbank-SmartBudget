import UIKit
import Combine

final class LoginViewController: UIViewController, FlowController {

    // MARK: Properties
    private let viewModel: LoginViewModelProtocol
    private var authTextFieldDelegate: AuthTextFieldDelegate?
    private var cancellables = Set<AnyCancellable>()
    private var keyboardObserver: KeyboardObserver?
    private var userInfo: User?
    var completionHandler: ((User?) -> Void)?

    private var loginView: LoginView {
        self.view as! LoginView
    }

    private lazy var passwordVisibilityButtonTapped = UIAction { [weak self] _ in
        guard let self else { return }
        viewModel.togglePasswordVisibility()
    }

    private lazy var loginButtonTapped = UIAction { [weak self] _ in
        guard let self else { return }
        guard let login = loginView.loginTextField.textField.text, let password = loginView.passwordTextField.textField.text else { return }
        viewModel.authenticateUser(login: login, password: password)
    }

    private lazy var registrationButtonTapped = UIAction { [weak self] _ in
        guard let self else { return }
        completionHandler?(nil)
    }

    // MARK: Initialization
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCicle
    override func loadView() {
        view = LoginView(textFieldFactory: TextFieldFactory(), buttonFactory: ButtonFactory())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        setupBindings()
        setupActions()
        setupKeyboardObserver()
    }

    // MARK: Private Methods
    private func setupTextFields() {
        authTextFieldDelegate = AuthTextFieldDelegate()
        authTextFieldDelegate?.setEmailTextField(loginView.loginTextField.textField)
        authTextFieldDelegate?.setPasswordTextField(loginView.passwordTextField.textField)
    }

    private func setupBindings() {
        viewModel.isPasswordVisiblePublisher
            .sink { [weak self] isVisible in
                self?.loginView.updatePasswordVisibility(isVisible)
            }
            .store(in: &cancellables)

        viewModel.isAuthenticatingPublisher
            .dropFirst()
            .sink { [weak self] isAuthenticating in
                self?.loginView.loginButton.buttonViewModel.buttonState = isAuthenticating ? .loading : .normal
            }.store(in: &cancellables)

        viewModel.userPublisher
            .compactMap { $0 }
            .sink { [weak self] user in
                self?.completionHandler?(user)
            }.store(in: &cancellables)

        authTextFieldDelegate?.$active
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] isActive in
                self?.loginView.loginButton.buttonViewModel.buttonState = isActive ? .normal : .disabled
            }
            .store(in: &cancellables)
    }

    private func setupKeyboardObserver() {
        keyboardObserver = KeyboardObserver(onShow: { [weak self] keyboardFrame in
            guard let self else { return }

            loginView.updateLayout(keyboardRect: keyboardFrame)
        }, onHide: { [weak self] in
            guard let self else { return }
            loginView.updateLayout()
        })
    }

    private func setupActions() {
        loginView.passwordVisibilityToggleButton.addAction(passwordVisibilityButtonTapped, for: .touchUpInside)
        loginView.loginButton.addAction(loginButtonTapped, for: .touchUpInside)
        loginView.registrationButton.addAction(registrationButtonTapped, for: .touchUpInside)
    }
}
