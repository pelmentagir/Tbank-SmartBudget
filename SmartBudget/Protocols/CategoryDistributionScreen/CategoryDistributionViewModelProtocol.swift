import Combine

protocol CategoryDistributionViewModelProtocol: AnyObject {
    // MARK: Published Properties
    var selectedCategory: Category? { get }
    var tags: [String] { get }

    var selectedCategoryPublisher: Published<Category?>.Publisher { get }
    var tagsPublisher: Published<[String]>.Publisher { get }

    // MARK: Methods
    func obtainCategories() -> [Category]
    func appendCategory(_ category: Category)
    func removeTag(tag: String)
    func selectedCategoryAtIndex(_ index: Int)
}

extension CategoryDistributionViewModel: CategoryDistributionViewModelProtocol {
    var selectedCategoryPublisher: Published<Category?>.Publisher { $selectedCategory }
    var tagsPublisher: Published<[String]>.Publisher { $tags }
}
