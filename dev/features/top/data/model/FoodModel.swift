
struct MealListModel: Codable, Hashable {
    let meals: [MealDetail]?
    
    enum CodingKeys: String, CodingKey {
        case meals
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.meals = try container.decodeIfPresent([MealDetail].self, forKey: .meals) ?? []
    }
}

