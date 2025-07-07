struct CategoryLimitChange: Codable {
    let categoryId: Int
    let percent: Int
}

struct ChangeCategoryLimitsRequest: Codable {
    let changeCategoryLimitRequestList: [CategoryLimitChange]
}
