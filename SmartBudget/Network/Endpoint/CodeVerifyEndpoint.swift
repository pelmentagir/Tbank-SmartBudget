import Foundation

struct CodeVerifyEndpoint: Endpoint {
    let code: String

    var path: String { "/api/v1/users/code-verify" }
    var method: HTTPMethod { .post }
    var headers: [String: String]? { nil }
    var body: Data? { nil }
    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "code", value: code)]
    }
}
