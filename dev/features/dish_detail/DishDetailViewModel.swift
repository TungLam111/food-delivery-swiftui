import Foundation
import SwiftUI

class DishDetailViewModel: ObservableObject {
    private let navigator: NavigationCoordinator;
    private let argument: DishDetailArgs;
    private var findMealDetailUsecase: FindMealDetailUsecase;
    private var shoppingCartLocalStorage: ShoppingCartLocalStorage;
    @Published var mealDetail : MealDetail?;
    
    init(
        navigator: NavigationCoordinator,
        findMealDetailUsecase: FindMealDetailUsecase,
        shoppingCartLocalStorage: ShoppingCartLocalStorage,
        argument: DishDetailArgs
    ) {
        self.navigator = navigator
        self.argument = argument
        self.findMealDetailUsecase = findMealDetailUsecase
        self.shoppingCartLocalStorage = shoppingCartLocalStorage
        setup();
    }
    
    func setup() {
        findMealDetail(dishId: self.argument.id);
    }
    
    func findMealDetail(dishId: String) {
        DispatchQueue.main.async{
            Task {
                do {
                    let data = try await self.findMealDetailUsecase.execute(dishId: dishId)
                    self.mealDetail = data?.meals.first;
                } catch {
                    print("Error fetching meals: \(error)")
                }
            }
        }
    }
    
    func onBack() {
        self.navigator.popLast()
    }
    
    func onFavorite() {
        
    }
    
    func addToCart() {
        let isAdded: Bool =  self.shoppingCartLocalStorage.saveOne(
            CartItem(
                id: self.mealDetail?.idMeal ?? "1",
                imageName: self.mealDetail?.strMealThumb ?? "",
                name: self.mealDetail?.strMeal ?? "",
                price: self.mealDetail?.price ?? "0" ,
                quantity: self.mealDetail?.quantity ?? 1
            )
        )
        
        if (isAdded) {
            self.navigator.popLast()
        }
    }
    
}
