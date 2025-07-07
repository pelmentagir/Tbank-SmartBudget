struct MainDataResponse: Decodable {
    let spentIncome: Int
    let leftIncome: Int
    let categoryDetailsDtoList: [CategorySpending]
    let imageUrl: String
}
