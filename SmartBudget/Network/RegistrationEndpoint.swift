import Foundation

struct RegistrationEndpoint: Endpoint {
    let request: AuthRequest

    var path: String { "/api/v1/users/sign-up/first-step" }
    var method: HTTPMethod { .post }

    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }

    var body: Data? {
        try? JSONEncoder().encode(request)
    }

    var queryItems: [URLQueryItem]? { nil }
}
