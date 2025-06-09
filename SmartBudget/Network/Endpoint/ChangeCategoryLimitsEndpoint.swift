import Foundation

struct ChangeCategoryLimitsEndpoint: Endpoint {
    private let requestData: Data

    var path: String { "/api/v1/category-limits/categories" }
    var method: HTTPMethod { .post }
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
    var body: Data? { requestData }
    var queryItems: [URLQueryItem]? { nil }

    init(changes: [CategoryLimitChange]) {
        let request = ChangeCategoryLimitsRequest(changeCategoryLimitRequestList: changes)
        self.requestData = try! JSONEncoder().encode(request)
    }
}
