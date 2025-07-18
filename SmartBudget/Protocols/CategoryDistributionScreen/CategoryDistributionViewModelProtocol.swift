import Combine

protocol CategoryDistributionViewModelProtocol: AnyObject {
    // MARK: Published Properties
    var selectedCategory: Category? { get }
    var tags: [String] { get }
    var isLoading: Bool { get }
    var success: Bool { get }

    var selectedCategoryPublisher: Published<Category?>.Publisher { get }
    var tagsPublisher: Published<[String]>.Publisher { get }
    var isLoadingPublisher: Published<Bool>.Publisher { get }
    var successPublisher: Published<Bool>.Publisher { get }

    // MARK: Methods
    func obtainCategories() -> [Category]
    func appendCategory(_ category: Category)
    func removeTag(tag: String)
    func selectedCategoryAtIndex(_ index: Int)
    func submitCategoryLimits()
}

extension CategoryDistributionViewModel: CategoryDistributionViewModelProtocol {
    var selectedCategoryPublisher: Published<Category?>.Publisher { $selectedCategory }
    var tagsPublisher: Published<[String]>.Publisher { $tags }
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
    var successPublisher: Published<Bool>.Publisher { $success }
}
