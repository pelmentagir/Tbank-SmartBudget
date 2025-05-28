import Combine

protocol CodeVerificationViewModelProtocol: AnyObject {
    // MARK: Published Properties
    var timerText: String { get set }
    var email: String { get set }

    var timerTextPublisher: Published<String>.Publisher { get }
    var emailPublisher: Published<String>.Publisher { get }

    // MARK: Methods
    func updateCode(at index: Int, with value: String)
    func startTimer()
    func stopTimer()
}

extension CodeVerificationViewModel: CodeVerificationViewModelProtocol {
    var timerTextPublisher: Published<String>.Publisher { $timerText }
    var emailPublisher: Published<String>.Publisher { $email }
}
