import Alamofire
import Foundation

final class NetworkService {
    static let shared = NetworkService()

    private let session: Session
    
    let plainSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.headers = .default
        return Session(configuration: configuration)
    }()

    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.headers = .default

        session = Session(
            configuration: configuration,
            interceptor: AuthInterceptor()
        )
    }

    func request<T: Decodable>(
        _ endpoint: Endpoint,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {

        guard let urlRequest = endpoint.urlRequest else {
            completion(.failure(NetworkError.invalidRequest))
            return
        }

        session.request(urlRequest)
            .validate()
            .responseDecodable(of: responseType) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    if let underlyingError = error.underlyingError {
                        print("Network error details: \(underlyingError)")
                    }
                    if let responseData = response.data,
                       let errorString = String(data: responseData, encoding: .utf8) {
                        print("Server response: \(errorString)")
                    }
                    completion(.failure(error))
                }
            }
    }
}

extension NetworkService {
    func uploadSecondStep(
        data: RegistrationSecondStepData,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        let url = "\(Environment.baseURL)/api/v1/users/sign-up/second-step"

        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]

        session.upload(
            multipartFormData: { multipart in
                multipart.append(Data(data.firstName.utf8), withName: "firstName")
                multipart.append(Data(data.lastName.utf8), withName: "lastName")
                multipart.append(Data(data.birthday.utf8), withName: "birthday")
                multipart.append(data.imageData,
                                 withName: "image",
                                 fileName: data.imageName,
                                 mimeType: data.mimeType)
            },
            to: url,
            method: .post,
            headers: headers
        )
        .validate()
        .response { response in
            switch response.result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension NetworkService {
    func requestWithEmptyResponse(
        _ endpoint: Endpoint,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        guard let urlRequest = endpoint.urlRequest else {
            completion(.failure(NetworkError.invalidRequest))
            return
        }

        session.request(urlRequest)
            .validate()
            .response { response in
                print(response.response?.statusCode)
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    if let underlyingError = error.underlyingError {
                        print("Network error details: \(underlyingError)")
                    }
                    if let responseData = response.data,
                       let errorString = String(data: responseData, encoding: .utf8) {
                        print("Server response: \(errorString)")
                    }
                    completion(.failure(error))
                }
            }
    }
}
