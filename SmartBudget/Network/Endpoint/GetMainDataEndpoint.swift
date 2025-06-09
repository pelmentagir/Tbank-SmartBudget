import Foundation

struct GetMainDataEndpoint: Endpoint {
    var path: String { "/api/v1/main" }
    var method: HTTPMethod { .get }
    var headers: [String: String]? { nil }
    var body: Data? { nil }
    var queryItems: [URLQueryItem]? { nil }
}
