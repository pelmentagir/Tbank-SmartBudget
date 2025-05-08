import UIKit

protocol FlowController: UIViewController {
    associatedtype Value

    var completionHandler: ((Value) -> Void)? { get set }
}
