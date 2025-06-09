import Foundation

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    private let isAuthenticatedKey = "isUserAuthenticated"
    
    private init() {}
    
    var isAuthenticated: Bool {
        get {
            UserDefaults.standard.bool(forKey: isAuthenticatedKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isAuthenticatedKey)
        }
    }
    
    func signIn() {
        isAuthenticated = true
    }
    
    func signOut() {
        isAuthenticated = false
    }
    
    func handleNetworkError(_ error: Error) -> String {
        let nsError = error as NSError
        if nsError.domain == NSURLErrorDomain {
            switch nsError.code {
            case -1009:
                return "Отсутствует подключение к интернету. Пожалуйста, проверьте ваше соединение и попробуйте снова."
            case -1001:
                return "Превышено время ожидания ответа от сервера. Пожалуйста, попробуйте позже."
            case -1004:
                return "Не удалось подключиться к серверу. Пожалуйста, попробуйте позже."
            default:
                return "Произошла ошибка сети. Пожалуйста, попробуйте позже."
            }
        }
        return "Произошла неизвестная ошибка. Пожалуйста, попробуйте позже."
    }
} 