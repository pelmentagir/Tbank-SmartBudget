import Foundation

struct UpdateFinancialGoalProgressEndpoint: Endpoint {
    let requestData: FinancialGoalProgressUpdate

    var path: String { "/api/v1/financial-goals/progress" }
    var method: HTTPMethod { .patch }
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }

    var body: Data? {
        let requestBody: [String: Any] = [
            "cost": requestData.cost,
            "goalId": requestData.goalId
        ]
        return try? JSONSerialization.data(withJSONObject: requestBody, options: [])
    }

    var queryItems: [URLQueryItem]? { nil }
}
