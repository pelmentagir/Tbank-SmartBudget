import UIKit

extension UIImage {

    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }

    static func getIconByCategory(categoryName: String) -> UIImage {
        switch categoryName {
        case "Продукты питания": return UIImage.icGroceries
        case "Рестораны и кафе": return UIImage.icSpoonAndFork
        case "Одежда и обувь": return UIImage.icClothing
        case "Товары для дома": return UIImage.icHomeGoods
        case "Электроника и бытовая техника": return UIImage.icElectronics
        case "Книги, музыка и видео": return UIImage.icBooksMedia
        case "Транспорт": return UIImage.icBus
        case "Автомобили и обслуживание": return UIImage.icCarService
        case "Здоровье и красота": return UIImage.icHeart
        case "Развлечения": return UIImage.icEntertainment
        case "Путешествия": return UIImage.icTravel
        case "Услуги": return UIImage.icServices
        case "Членство и подписки": return UIImage.icSubscriptions
        case "Профессиональные услуги": return UIImage.icProfessional
        case "Финансовые услуги": return UIImage.icFinance
        case "Государственные услуги": return UIImage.icGovernment
        default:
            return UIImage.icGroceries
        }
    }
}
