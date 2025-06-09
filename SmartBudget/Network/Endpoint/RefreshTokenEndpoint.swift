import Foundation

struct RefreshTokenEndpoint: Endpoint {
    let refreshToken: String

    var path: String { "/api/v1/users/sign-in/token" }
    var method: HTTPMethod { .post }
    var headers: [String: String]? {
        return ["Authorization": "Bearer \(refreshToken)"]
    }
    var body: Data? { nil }
    var queryItems: [URLQueryItem]? { nil }
}
