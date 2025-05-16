import UIKit
import Swinject

final class AppContainer {

    // MARK: Properties
    private var container = Container()

    // MARK: Initializated
    init() {
        setupDependency()
    }

    // MARK: Public Methods
    func resolveController<T: FlowController>(_ type: T.Type) -> T {
        guard let controller = container.resolve(type) else {
            fatalError("Controller of type \(type) not registered.")
        }
        return controller
    }

    // MARK: Private Methods
    private func setupDependency() {

        // MARK: ViewModels
        container.register(LoginViewModel.self) { _ in
            return LoginViewModel()
        }

        container.register(CodeVerificationViewModel.self) { _ in
            return CodeVerificationViewModel()
        }

        // MARK: Controller
        container.register(LoginViewController.self) { resolver in
            return LoginViewController(viewModel: resolver.resolve(LoginViewModel.self)!)
        }

        container.register(CodeVerificationViewController.self) { resolver in
            return CodeVerificationViewController(viewModel: resolver.resolve(CodeVerificationViewModel.self)!)
        }
    }
}
