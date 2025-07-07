import Combine
import Foundation

final class SearchViewModel {

    // MARK: Published Properties
    @Published private(set) var categories: [CategoryItem] = []
    @Published private(set) var selectedCategory: CategoryItem?

    // MARK: Private
    private var allCategories: [CategoryItem] = []
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization
    init() {
        loadCategories()
    }

    // MARK: - Networking
    private func loadCategories() {
        let endpoint = GetCategoryLimitsEndpoint()

        NetworkService.shared.request(endpoint, responseType: CategoryResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.allCategories = response.categories
                    self?.categories = response.categories
                }
            case .failure(let error):
                print("Ошибка загрузки категорий: \(error)")
            }
        }
    }

    // MARK: - Public
    func findCategoryAtIndex(_ index: Int) {
        selectedCategory = categories[index]
    }

    func search(query: String) {
        if query.isEmpty {
            categories = allCategories
        } else {
            let lowercasedQuery = query.lowercased()
            categories = allCategories.filter {
                $0.categoryName.lowercased().contains(lowercasedQuery)
            }
        }
    }
}
