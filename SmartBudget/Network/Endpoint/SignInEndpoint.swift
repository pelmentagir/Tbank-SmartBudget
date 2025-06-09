import Foundation

struct SignInEndpoint: Endpoint {
    let request: AuthRequest

    var path: String { "/api/v1/users/sign-in" }
    var method: HTTPMethod { .post }

    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }

    var body: Data? {
        try? JSONEncoder().encode(request)
    }

    var queryItems: [URLQueryItem]? { nil }
}
