import Foundation
import SwiftUI

class DishDetailViewModel: ObservableObject {
    private let navigator: NavigationCoordinator;
    private let argument: DishDetailArgs;
    private var findMealDetailUsecase: FindMealDetailUsecase;
    private var addToShoppingBasketUsecase: AddToShoppingBasketUsecase;
    private var shoppingCartLocalStorage: ShoppingCartLocalStorage;
    private var findOneBasketUsecase: FindOneBasketUsecase;
    @Published var mealDetail : MealDetail?;
    
    var toppings : [ToppingModel] = [
        ToppingModel(name: "Size", type: "size", options: ["Small", "Medium", "Big"]),
        ToppingModel(name: "Sugar", type: "sugar", options: ["Free", "Half", "Full"]),
        ToppingModel(name: "Milk", type: "milk", options: ["Oat milk", "Dense", "Normal"])
    ]
    
    @Published var toppingSelection: [String: Int] = [:]
    
    init(
        navigator: NavigationCoordinator,
        findMealDetailUsecase: FindMealDetailUsecase,
        addToShoppingBasketUsecase: AddToShoppingBasketUsecase,
        shoppingCartLocalStorage: ShoppingCartLocalStorage,
        findOneBasketUsecase: FindOneBasketUsecase,
        argument: DishDetailArgs
    ) {
        self.navigator = navigator
        self.argument = argument
        self.findMealDetailUsecase = findMealDetailUsecase
        self.shoppingCartLocalStorage = shoppingCartLocalStorage
        self.addToShoppingBasketUsecase = addToShoppingBasketUsecase
        self.findOneBasketUsecase = findOneBasketUsecase
        
        setup();
    }
    
    func setup() {
        findMealDetail(dishId: self.argument.id);
        getBasketInfo();
        
    }
    
    func getBasketInfo() {
        DispatchQueue.main.async {
            Task {
                var basket: BasketItemResponse? = nil;
                if self.argument.basketId != nil {
                    let result = try await self.findOneBasketUsecase.execute(basketId: self.argument.basketId!)
                    if result.isSuccess {
                        basket = result.data ?? nil
                    }
                }
                
                self.toppings.forEach { eachTopping in
                    if !eachTopping.options.isEmpty {
                        if basket == nil {
                            self.toppingSelection[eachTopping.type] = 0
                        } else {
                            self.toppingSelection[eachTopping.type] = basket?.topping[eachTopping.type]
                        }
                    }
                }
            }
        }
    }
    
    func findMealDetail(dishId: String) {
        DispatchQueue.main.async {
            Task {
                do {
                    let data = try await self.findMealDetailUsecase.execute(dishId: dishId)
                    self.mealDetail = data?.meals.first?.initPriceAndQuantity();
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
        DispatchQueue.main.async {
            Task  {
                do {
                    if (self.mealDetail != nil) {
                        let result: DataState<BasketItemResponse?> = try await self.addToShoppingBasketUsecase.execute(
                            basket: AddCartItem(
                            mealId: self.mealDetail!.idMeal!,
                            price: self.mealDetail!.price!,
                            quantity: self.mealDetail!.quantity!,
                            topping: self.toppingSelection,
                            mealName: self.mealDetail?.strMeal ?? "",
                            mealCategory: self.mealDetail?.strCategory ?? "",
                            mealImage: self.mealDetail?.strMealThumb ?? ""
                        ))
                        
                        
                        if (result.isSuccess) {
                            self.navigator.popLast()
                        }
                    }
                } catch {
                    print("Error adding basket: \(error)")
                }
            }
        }
    }
    
    func onUpdateOption(type: String, idx: Int) {
        self.toppingSelection[type] = idx;
    }
}
