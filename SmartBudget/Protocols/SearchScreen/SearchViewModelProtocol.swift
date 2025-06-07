import Combine

protocol SearchViewModelProtocol: AnyObject {
    // MARK: Published Properties
    var categories: [Category] { get }
    var selectedCategory: Category? { get }

    var categoriesPublisher: Published<[Category]>.Publisher { get }
    var selectedCategoryPublisher: Published<Category?>.Publisher { get }

    // MARK: Methods
    func findCategoryAtIndex(_ index: Int)
    func search(query: String)
}

extension SearchViewModel: SearchViewModelProtocol {
    var categoriesPublisher: Published<[Category]>.Publisher { $categories }
    var selectedCategoryPublisher: Published<Category?>.Publisher { $selectedCategory }
}
