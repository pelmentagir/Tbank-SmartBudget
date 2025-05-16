import UIKit

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
    @Published var email: String = "example@gmail.com"

    // MARK: Private Properties
    private var codeFields: [String] = Array(repeating: "", count: .codeLength)
    private var timer: Timer?
    private var secondRemaining: Int = .initialTimerSeconds

    // MARK: Public Methods
    func updateCode(at index: Int, with value: String) {
        codeFields[index] = value
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
