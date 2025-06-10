import Foundation
import UserNotifications

protocol IPushNotificationCenter {

    @available(iOS 16, *)
    func registerForNotification() async throws -> Bool

    func showNotification(
        for request: UNNotificationRequest,
        completion: @escaping ((Result<Void, NetworkError>) -> Void)
    )
    func registerForNotification() -> Bool
}

final class PushNotificationCenter: NSObject, IPushNotificationCenter {

    private let notificationCenter = UNUserNotificationCenter.current()

    override init() {
        super.init()
        notificationCenter.delegate = self
    }

    func showNotification(
        for request: UNNotificationRequest,
        completion: @escaping ((Result<Void, NetworkError>) -> Void)
    ) {
        notificationCenter.getNotificationSettings { settings in
            guard
                settings.authorizationStatus == .authorized
            else {
                completion(.failure(.serverError))
                return
            }
            self.notificationCenter.add(request) { error in
                if let error = error {
                    completion(
                        .failure(
                            .invalidRequest
                        )
                        
                    )
                }
            }
        }
    }

    @available(iOS 16, *)
    func registerForNotification() async throws -> Bool {
        try await notificationCenter.requestAuthorization(options: [.alert, .badge, .sound])
    }

    func registerForNotification() -> Bool {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in }
        return true
    }
}

extension PushNotificationCenter: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
}
