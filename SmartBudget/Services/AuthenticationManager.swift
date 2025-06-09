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
} 