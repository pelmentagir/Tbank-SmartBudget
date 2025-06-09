import Foundation

struct SetIncomeEndpoint: Endpoint {
    let income: Int
    let dayOfSalary: Int

    var path: String { "/api/v1/users/income" }
    var method: HTTPMethod { .post }
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }

    var body: Data? {
        let payload = [
            "income": income,
            "dayOfSalary": dayOfSalary
        ]
        return try? JSONSerialization.data(withJSONObject: payload, options: [])
    }

    var queryItems: [URLQueryItem]? { nil }
}
