import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var flowCompletionHandler: (() -> Void)? { get set }

    func start()
}
