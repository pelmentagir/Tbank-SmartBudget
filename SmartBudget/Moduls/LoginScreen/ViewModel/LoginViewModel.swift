import Foundation
import Combine

final class LoginViewModel {

    // MARK: Published Properties
    @Published var isPasswordVisible: Bool = false

    // MARK: Public Methods
    func togglePasswordVisibility() {
        isPasswordVisible.toggle()
    }
}
