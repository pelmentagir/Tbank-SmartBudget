import Foundation
import Combine

final class CategoryDistributionViewModel {

    // MARK: Published Properties
    @Published private(set) var selectedCategory: Category?
    @Published private(set) var tags: [String] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var success: Bool = false

    // MARK: Properties
    private var categories: [Category] = [
        Category(id: 1, icon: .icGroceries, name: "Продукты", discription: "Покупки в супермаркетах и продуктовых магазинах", backgroundColor: .systemBlue),
        Category(id: 9, icon: .icHeart, name: "Здоровье", discription: "Медицина, аптеки, фитнес и wellness", backgroundColor: .systemRed),
        Category(id: 7, icon: .icBus, name: "Транспорт", discription: "Общественный транспорт, такси и топливо", backgroundColor: .systemGreen),
        Category(id: 2, icon: .icSpoonAndFork, name: "Кафе и рестораны", discription: "Питание вне дома, кофе и фастфуд", backgroundColor: .systemPurple),
        Category(id: 10, icon: .icEntertainment, name: "Развлечения", discription: "Кино, концерты, хобби и досуг", backgroundColor: .systemYellow),
        Category(id: 19, icon: .icPlus, name: "Создать", discription: "", backgroundColor: .systemGray)
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

    func submitCategoryLimits() {
        isLoading = true

        let changes: [CategoryLimitChange] = selectedCategories.map {
            CategoryLimitChange(categoryId: $0.id, percent: $0.percentage)
        }

        let endpoint = ChangeCategoryLimitsEndpoint(changes: changes)

        NetworkService.shared.requestWithEmptyResponse(endpoint) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success:
                    self.success = true
                case .failure:
                    self.success = false
                }
            }
        }
    }

    // MARK: Private Methods
    private func tagString(for category: Category) -> String {
        "\(category.name) | \(category.percentage)% (\(category.amount) ₽)"
    }
}
