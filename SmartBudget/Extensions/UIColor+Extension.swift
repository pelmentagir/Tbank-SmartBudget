import UIKit

extension UIColor {
    static func getBackgroundColorByCategory(categoryName: String) -> UIColor {
        switch categoryName {
        case "Продукты питания": return UIColor.systemBlue
        case "Рестораны и кафе": return UIColor.systemPurple
        case "Одежда и обувь": return UIColor.systemCyan
        case "Товары для дома": return UIColor.systemGray
        case "Электроника и бытовая техника": return UIColor.systemMint
        case "Книги, музыка и видео": return UIColor.systemPink
        case "Транспорт": return UIColor.systemGreen
        case "Автомобили и обслуживание": return UIColor.systemTeal
        case "Здоровье и красота": return UIColor.systemRed
        case "Развлечения": return UIColor.systemYellow
        case "Путешествия": return UIColor.systemOrange
        case "Услуги": return UIColor.systemIndigo
        case "Членство и подписки": return UIColor.systemBlue
        case "Профессиональные услуги": return UIColor.systemPink
        case "Финансовые услуги": return UIColor.systemBrown
        case "Государственные услуги": return UIColor.systemRed
        default:
            return UIColor.systemGray
        }
    }

    static func getColorForPieChart(categories: [CategorySpendingDTO]) -> [UIColor] {
        var colors: [UIColor] = []

        for category in categories {
            colors.append(getBackgroundColorByCategory(categoryName: category.categoryName).withAlphaComponent(0.6))
        }

        return colors
    }
}
