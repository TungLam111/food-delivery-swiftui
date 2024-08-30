
import Foundation

class VerifyOrderResponseModel: Identifiable, Codable {
    var isValid: Bool
    var message : String?
    var foodCost: Double
    var discount: Double?
    var totalCost: Double?
    var deliveryCost: Double
    
    enum CodingKeys: String, CodingKey {
        case isValid
        case message
        case foodCost
        case discount
        case totalCost
        case deliveryCost
    }
    
    init(isValid: Bool, message: String? = nil, foodCost: Double, discount: Double? = nil, totalCost: Double? = nil, deliveryCost: Double) {
        self.isValid = isValid
        self.message = message
        self.foodCost = foodCost
        self.discount = discount
        self.totalCost = totalCost
        self.deliveryCost = deliveryCost
    }
}
