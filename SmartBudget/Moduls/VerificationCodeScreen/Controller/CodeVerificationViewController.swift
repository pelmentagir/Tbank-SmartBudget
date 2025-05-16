import UIKit
import Combine

final class CodeVerificationViewController: UIViewController, FlowController {

    private var verificationCodeView: CodeVerificationView {
        self.view as! CodeVerificationView
    }

    // MARK: - Properties
    private let viewModel: CodeVerificationViewModel
    private var cancellables = Set<AnyCancellable>()
    var completionHandler: ((String) -> Void)?

    // MARK: Initialization
    init(viewModel: CodeVerificationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        viewModel.stopTimer()
    }

    // MARK: LifeCicle
    override func loadView() {
        let codeVerificationView = CodeVerificationView(textFieldFactory: TextFieldFactory())
        codeVerificationView.delegate = self
        self.view = codeVerificationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.startTimer()
    }

    // MARK: - Private Methods
    private func setupBindings() {
        viewModel.$timerText
            .sink { [weak self] text in
                self?.verificationCodeView.updateTimerText(text)
            }
            .store(in: &cancellables)

        viewModel.$email
            .sink { [weak self] email in
                self?.verificationCodeView.updateEmailText(email)
            }
            .store(in: &cancellables)
    }
}

// MARK: - CodeVerificationViewDelegate

extension CodeVerificationViewController: CodeVerificationViewDelegate {
    func didUpdateCode(at index: Int, with value: String) {
        viewModel.updateCode(at: index, with: value)
    }

    func didDeleteBackward(at index: Int) {
        let prevField = index - 1
        if prevField >= 0 {
            verificationCodeView.updateField(at: prevField, text: "", isEnabled: true)
            verificationCodeView.updateField(at: index, text: "", isEnabled: false)
            viewModel.updateCode(at: prevField, with: "")
        }
    }
}
