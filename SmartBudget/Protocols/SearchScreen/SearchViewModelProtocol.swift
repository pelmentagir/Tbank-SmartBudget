import Combine

protocol SearchViewModelProtocol: AnyObject {
    // MARK: Published Properties
    var categories: [CategoryItem] { get }
    var selectedCategory: CategoryItem? { get }

    var categoriesPublisher: Published<[CategoryItem]>.Publisher { get }
    var selectedCategoryPublisher: Published<CategoryItem?>.Publisher { get }

    // MARK: Methods
    func findCategoryAtIndex(_ index: Int)
    func search(query: String)
}

extension SearchViewModel: SearchViewModelProtocol {
    var categoriesPublisher: Published<[CategoryItem]>.Publisher { $categories }
    var selectedCategoryPublisher: Published<CategoryItem?>.Publisher { $selectedCategory }
}
