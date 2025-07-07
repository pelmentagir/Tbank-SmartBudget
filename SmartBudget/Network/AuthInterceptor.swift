import Foundation
import Alamofire

final class AuthInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        if let token = TokenStorage.shared.accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        completion(.success(request))
    }

    private var isRefreshing = false

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard request.retryCount < 1,
              let response = request.task?.response as? HTTPURLResponse,
              [401, 403].contains(response.statusCode) else {
            completion(.doNotRetry)
            return
        }

        guard !isRefreshing else {
            completion(.doNotRetry)
            return
        }

        isRefreshing = true
        AuthService.shared.refreshToken { result in
            self.isRefreshing = false
            switch result {
            case .success:
                completion(.retry)
            case .failure:
                completion(.doNotRetry)
            }
        }
    }
}
