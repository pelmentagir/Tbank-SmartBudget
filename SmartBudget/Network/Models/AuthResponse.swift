struct AuthResponse: Decodable {
    let accessToken: String?
    let refreshToken: String?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case accessToken
        case refreshToken
        case message
    }
}
