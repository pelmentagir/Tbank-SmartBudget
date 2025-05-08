import Foundation

protocol CodeVerificationViewDelegate: AnyObject {
    func didUpdateCode(at index: Int, with value: String)
    func didDeleteBackward(at index: Int)
}
