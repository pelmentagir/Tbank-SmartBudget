import UIKit

protocol KeyboardObservable: AnyObject {
    var keyboardObserver: KeyboardObserver? { get set }
    func startKeyboardObserving(onShow: @escaping (_ keyboardFrame: CGRect) -> Void, onHide: @escaping () -> Void)
    func stopKeyboardObserving()
}

final class KeyboardObserver {

    // MARK: Properties
    private var onShowHandler: ((_ keyboardFrame: CGRect) -> Void)?
    private var onHideHandler: (() -> Void)?

    // MARK: Initialization
    init(onShow: @escaping (_ keyboardFrame: CGRect) -> Void, onHide: @escaping () -> Void) {
        onShowHandler = onShow
        onHideHandler = onHide
        startObservering()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: Public Methods
    func stopObserving() {
        NotificationCenter.default.removeObserver(self)
        onHideHandler = nil
        onShowHandler = nil
    }

    // MARK: Private Methods
    private func startObservering() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardWillShow(notification: )),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardWillHide(notification: )),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }

    @objc private func handleKeyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        onShowHandler?(keyboardFrame)
    }

    @objc private func handleKeyboardWillHide(notification: Notification) {
        onHideHandler?()
    }
}

// MARK: KeyboardObservable
extension KeyboardObservable {

    func startKeyboardObserving(onShow: @escaping (CGRect) -> Void, onHide: @escaping () -> Void) {
        keyboardObserver = KeyboardObserver(onShow: onShow, onHide: onHide)
    }

    func stopKeyboardObserving() {
        keyboardObserver?.stopObserving()
        keyboardObserver = nil
    }
}
