import Foundation
import SwiftUI

class Order: Codable, Hashable, Equatable, Identifiable  {
  
    static func == (lhs: Order, rhs: Order) -> Bool {
         lhs.hashValue == rhs.hashValue
    }
    
    // Hashable and Equatable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id = UUID()
    var orderNumber: String
    var dishes: [MealDetail]
    
    init(orderNumber: String, dishes: [MealDetail]) {
        self.orderNumber = orderNumber
        self.dishes = dishes
    }
}

class OrderViewModel: ObservableObject {
    private let navigator: NavigationCoordinator;
    private var searchByTextUsecase: SearchByTextUsecase;

    @Published var orders : [Order] = [];
    
    init(
        navigator: NavigationCoordinator,
        searchByTextUsecase: SearchByTextUsecase
    ) {
        self.navigator = navigator
        self.searchByTextUsecase = searchByTextUsecase
        setup()
    }
    
    func setup(){
        DispatchQueue.main.async{
            Task {
                do {
                    let data = try await self.searchByTextUsecase.execute(text: "chi")
                    let historyItems = data?.meals ?? [];
                    
                    let sampleOrders = [
                        Order(orderNumber: "001", dishes: historyItems),
                        Order(orderNumber: "002", dishes: historyItems),
                        Order(orderNumber: "003", dishes: historyItems)
                    ]
                    
                    self.orders = sampleOrders;
                    
                    
                } catch {
                    // Handle error if needed
                    print("Error fetching meals: \(error)")
                }
            }
        }
    }
    
    func onBack(){
        
    }
    
    func navToMealDetail(dishId: String) {
        self.navigator.push(RootViewModel.Destination.dishDetail(
            vm:
                DependencyInjector.instance.viewModelsDI.dishDetail(navigationCoordinator: self.navigator, args: DishDetailArgs(id: dishId, basketId: nil))
        ))
    }
}
