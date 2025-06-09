import Foundation
import Alamofire

final class AuthService {
    static let shared = AuthService()

    func login(email: String, password: String, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        let request = AuthRequest(email: email, password: password)
        let endpoint = SignInEndpoint(request: request)
        
        NetworkService.shared.request(endpoint, responseType: AuthResponse.self) { result in
            switch result {
            case .success(let authResponse):
                if let accessToken = authResponse.accessToken {
                    TokenStorage.shared.accessToken = accessToken
                    if let refreshToken = authResponse.refreshToken {
                        TokenStorage.shared.refreshToken = refreshToken
                    }
                }
                completion(.success(authResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func refreshToken(completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        guard let refresh = TokenStorage.shared.refreshToken else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No refresh token available"])))
            return
        }

        let endpoint = RefreshTokenEndpoint(refreshToken: refresh)

        NetworkService.shared.request(endpoint, responseType: AuthResponse.self) { result in
            switch result {
            case .success(let authResponse):
                if let accessToken = authResponse.accessToken {
                    TokenStorage.shared.accessToken = accessToken
                    if let refreshToken = authResponse.refreshToken {
                        TokenStorage.shared.refreshToken = refreshToken
                    }
                }
                completion(.success(authResponse))
            case .failure(let error):
                TokenStorage.shared.clearTokens()
                completion(.failure(error))
            }
        }
    }
}
