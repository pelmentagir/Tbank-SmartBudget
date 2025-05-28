import Foundation

final class SearchViewModel {

    // MARK: Published Properties
    @Published private(set) var categories: [Category] = []
    @Published private(set) var selectedCategory: Category?

    // MARK: Properties
    private let allCategories: [Category] = [
        Category(icon: .icGroceries, name: "Продукты", discription: "Покупки в супермаркетах и продуктовых магазинах", backgroundColor: .systemBlue),
        Category(icon: .icHeart, name: "Здоровье", discription: "Медицина, аптеки, фитнес и wellness", backgroundColor: .systemRed),
        Category(icon: .icBus, name: "Транспорт", discription: "Общественный транспорт, такси и топливо", backgroundColor: .systemGreen),
        Category(icon: .icSpoonAndFork, name: "Кафе и рестораны", discription: "Питание вне дома, кофе и фастфуд", backgroundColor: .systemPurple),
        Category(icon: .icEntertainment, name: "Развлечения", discription: "Кино, концерты, хобби и досуг", backgroundColor: .systemYellow)
    ]

    // MARK: Initialization
    init() {
        categories = allCategories
    }

    // MARK: Public Methods
    func findCategoryAtIndex(_ index: Int) {
        selectedCategory = categories[index]
    }

    func search(query: String) {
        if query.isEmpty {
            categories = allCategories
        } else {
            let lowercasedQuery = query.lowercased()
            categories = allCategories.filter {
                $0.name.lowercased().contains(lowercasedQuery) ||
                $0.discription.lowercased().contains(lowercasedQuery)
            }
        }
    }
}
