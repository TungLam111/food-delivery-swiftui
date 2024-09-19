import Foundation

struct CategoryFoodListModel: Codable, Hashable {
    let categories: [CategoryFoodModel]
}

class CategoryFoodModel: Codable, Hashable, Equatable, Identifiable {
    static func == (
        lhs: CategoryFoodModel,
        rhs: CategoryFoodModel
      ) -> Bool {
        lhs.hashValue == rhs.hashValue
      }
    
    var idCategory: String
    var strCategory: String
    var strCategoryThumb: String
    var strCategoryDescription: String

    enum CodingKeys: String, CodingKey {
        case idCategory
        case strCategory
        case strCategoryThumb
        case strCategoryDescription
    }
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(idCategory)
           hasher.combine(strCategory)
           hasher.combine(strCategoryThumb)
           hasher.combine(strCategoryDescription)
       }
}
