import UIKit
import Combine

final class LoginViewController: UIViewController, FlowController {

    // MARK: Properties
    private let viewModel: LoginViewModel
    private var passwordTextFieldDelegate: PasswordTextFieldDelegate?
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
        completionHandler?(User(login: "fsd", password: "Fds"))
    }

    // MARK: Initialization
    init(viewModel: LoginViewModel) {
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
        setupBindings()
        setupActions()
        setupTextFields()
        setupKeyboardObserver()
    }

    // MARK: Private Methods
    private func setupTextFields() {
        passwordTextFieldDelegate = PasswordTextFieldDelegate()
        loginView.passwordTextField.textField.delegate = passwordTextFieldDelegate
    }

    private func setupBindings() {
        viewModel.$isPasswordVisible
            .sink { [weak self] isVisible in
                self?.loginView.updatePasswordVisibility(isVisible)
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
    }
}
