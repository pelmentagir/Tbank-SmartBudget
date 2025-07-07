import UIKit
import Combine

private extension Int {
    static let initialTimerSeconds: Int = 59
    static let codeLength: Int = 4
}

private extension Double {
    static let timerInterval: TimeInterval = 1.0
}

final class CodeVerificationViewModel {

    // MARK: Published Properties
    @Published var timerText: String = ""
    @Published var email: String
    @Published var isLoading: Bool = false
    @Published var error: String?
    @Published var success = false

    // MARK: Private Properties
    private var codeFields: [String] = Array(repeating: "", count: .codeLength)
    private var timer: Timer?
    private var secondRemaining: Int = .initialTimerSeconds
    private var cancellables = Set<AnyCancellable>()

    init(email: String) {
        self.email = email
    }
    
    // MARK: Public Methods
    func updateCode(at index: Int, with value: String) {
        codeFields[index] = value

        if index == .codeLength - 1 && !value.isEmpty {
            verifyCode()
        }
    }

    func verifyCode() {
        let code = codeFields.joined()
        guard code.count == .codeLength else { return }

        isLoading = true
        error = nil

        let endpoint = CodeVerifyEndpoint(code: code)
        NetworkService.shared.requestWithEmptyResponse(endpoint) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false

                switch result {
                case .success:
                    print("Verification successful")
                    self?.success = true
                case .failure(let error):
                    print(error)
                    self?.error = error.localizedDescription
                }
            }
        }
    }

    func startTimer() {
        secondRemaining = .initialTimerSeconds
        updateTimerText()
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: .timerInterval, repeats: true, block: { [weak self] _ in
            self?.updateTimer()
        })
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    // MARK: Private Methods
    private func updateTimerText() {
        timerText = "Отправим код повторно через \(secondRemaining) сек"
    }

    private func updateTimer() {
        if secondRemaining > 0 {
            secondRemaining -= 1
            updateTimerText()
        } else {
            stopTimer()
            timerText = "Отправить код повторно"
        }
    }
}
