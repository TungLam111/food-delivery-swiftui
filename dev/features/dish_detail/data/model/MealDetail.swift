struct MealDetailListModel: Codable, Hashable {
    var meals: [MealDetail]
    
    init(meals: [MealDetail]) {
        self.meals = meals
    }
}

class MealDetail: Codable, Hashable, Equatable, Identifiable {
    var idMeal: String?
    var strMeal: String?
    var strDrinkAlternate: String?
    var strCategory: String?
    var strArea: String?
    var strInstructions: String?
    var strMealThumb: String?
    var strTags: String?
    var strYoutube: String?
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strIngredient4: String?
    var strIngredient5: String?
    var strIngredient6: String?
    var strIngredient7: String?
    var strIngredient8: String?
    var strIngredient9: String?
    var strIngredient10: String?
    var strIngredient11: String?
    var strIngredient12: String?
    var strIngredient13: String?
    var strIngredient14: String?
    var strIngredient15: String?
    var strIngredient16: String?
    var strIngredient17: String?
    var strIngredient18: String?
    var strIngredient19: String?
    var strIngredient20: String?
    var strMeasure1: String?
    var strMeasure2: String?
    var strMeasure3: String?
    var strMeasure4: String?
    var strMeasure5: String?
    var strMeasure6: String?
    var strMeasure7: String?
    var strMeasure8: String?
    var strMeasure9: String?
    var strMeasure10: String?
    var strMeasure11: String?
    var strMeasure12: String?
    var strMeasure13: String?
    var strMeasure14: String?
    var strMeasure15: String?
    var strMeasure16: String?
    var strMeasure17: String?
    var strMeasure18: String?
    var strMeasure19: String?
    var strMeasure20: String?
    var price: String?
    var quantity: Int?
    
   
    func initPriceAndQuantity() -> MealDetail {
        self.price = "19.99"
        self.quantity = 1
        return self;
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(idMeal)
    }
    
    static func ==(lhs: MealDetail, rhs: MealDetail) -> Bool {
        return lhs.idMeal == rhs.idMeal
    }
    
    enum CodingKeys: String, CodingKey {
           case idMeal
           case strMeal
           case strDrinkAlternate
           case strCategory
           case strArea
           case strInstructions
           case strMealThumb
           case strTags
           case strYoutube
           case strIngredient1
           case strIngredient2
           case strIngredient3
           case strIngredient4
           case strIngredient5
           case strIngredient6
           case strIngredient7
           case strIngredient8
           case strIngredient9
           case strIngredient10
           case strIngredient11
           case strIngredient12
           case strIngredient13
           case strIngredient14
           case strIngredient15
           case strIngredient16
           case strIngredient17
           case strIngredient18
           case strIngredient19
           case strIngredient20
           case strMeasure1
           case strMeasure2
           case strMeasure3
           case strMeasure4
           case strMeasure5
           case strMeasure6
           case strMeasure7
           case strMeasure8
           case strMeasure9
           case strMeasure10
           case strMeasure11
           case strMeasure12
           case strMeasure13
           case strMeasure14
           case strMeasure15
           case strMeasure16
           case strMeasure17
           case strMeasure18
           case strMeasure19
           case strMeasure20
       }
}

