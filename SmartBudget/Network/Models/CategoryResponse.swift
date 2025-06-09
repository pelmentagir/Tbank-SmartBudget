struct CategoryResponse: Decodable {
    let categories: [CategoryItem]
}

struct CategoryItem: Decodable, Hashable {
    let categoryName: String
    let categoryId: Int
}
