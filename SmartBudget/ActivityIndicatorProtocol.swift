import Foundation

protocol ActivityIndicatorProtocol {
    func startAnimating()
    func stopAnimating()

    var isAnimating: Bool { get }
}
