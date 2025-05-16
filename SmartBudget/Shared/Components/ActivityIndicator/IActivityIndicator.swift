import Foundation

protocol IActivityIndicator {
    func startAnimating()
    func stopAnimating()

    var isAnimating: Bool { get }
}
