import Foundation

struct GetCategoryLimitsEndpoint: Endpoint {
    var path: String { "/api/v1/category-limits/categories" }
    var method: HTTPMethod { .get }
    var headers: [String: String]? { nil }
    var body: Data? { nil }
    var queryItems: [URLQueryItem]? { nil }
}
