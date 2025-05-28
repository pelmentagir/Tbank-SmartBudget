import Foundation
import Combine

final class CategoryDistributionViewModel {

    // MARK: Published Propertied
    @Published private(set) var selectedCategory: Category?
    @Published private(set) var tags: [String] = []

    // MARK: Properties
    private var categories: [Category] = [
        Category(
            icon: .icGroceries,
            name: "Продукты",
            discription: "Покупки в супермаркетах и продуктовых магазинах",
            backgroundColor: .systemBlue
        ),
        Category(
            icon: .icHeart,
            name: "Здоровье",
            discription: "Медицина, аптеки, фитнес и wellness",
            backgroundColor: .systemRed
        ),
        Category(
            icon: .icBus,
            name: "Транспорт",
            discription: "Общественный транспорт, такси и топливо",
            backgroundColor: .systemGreen
        ),
        Category(
            icon: .icSpoonAndFork,
            name: "Кафе и рестораны",
            discription: "Питание вне дома, кофе и фастфуд",
            backgroundColor: .systemPurple
        ),
        Category(
            icon: .icEntertainment,
            name: "Развлечения",
            discription: "Кино, концерты, хобби и досуг",
            backgroundColor: .systemYellow
        ),
        Category(
            icon: .icPlus,
            name: "Создать",
            discription: "",
            backgroundColor: .systemGray
        )
    ]

    private var selectedCategories: [Category] = []

    // MARK: Public Methods
    func obtainCategories() -> [Category] {
        categories
    }

    func appendCategory(_ category: Category) {
        if let index = selectedCategories.firstIndex(where: { $0.name == category.name }) {
            selectedCategories[index] = category
            tags[index] = tagString(for: category)
        } else {
            tags.append(tagString(for: category))
            selectedCategories.append(category)
        }
    }

    func removeTag(tag: String) {
        if let index = selectedCategories.firstIndex(where: {
            "\($0.name) | \($0.percentage)% (\($0.amount) ₽)" == tag
        }) {
            tags.remove(at: index)
            selectedCategories.remove(at: index)
        }
    }

    func selectedCategoryAtIndex(_ index: Int) {
        selectedCategory = categories[index]
    }

    // MARK: Private Methods
    private func tagString(for category: Category) -> String {
        "\(category.name) | \(category.percentage)% (\(category.amount) ₽)"
    }
}
