import Foundation

struct SpendingEndpoint: Endpoint {
    let request: SpendingRequest
    
    var path: String { "/api/v1/spending" }
    var method: HTTPMethod { .post }
    
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
    
    var body: Data? {
        try? JSONEncoder().encode(request)
    }
    
    var queryItems: [URLQueryItem]? { nil }
}
