import Foundation

struct GetFinancialGoalsEndpoint: Endpoint {
    var path: String { "/api/v1/financial-goals" }
    var method: HTTPMethod { .get }
    var headers: [String: String]? { nil }
    var body: Data? { nil }
    var queryItems: [URLQueryItem]? { nil }
}
