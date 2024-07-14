import Foundation
import SwiftUI

class DishDetailViewModel: ObservableObject {
    private let navigator: NavigationCoordinator;
    private let argument: DishDetailArgs;
    private var findMealDetailUsecase: FindMealDetailUsecase;
    @Published var mealDetail : MealDetail?;

    init(
        navigator: NavigationCoordinator,
        findMealDetailUsecase: FindMealDetailUsecase,
        argument: DishDetailArgs
    ) {
        self.navigator = navigator
        self.argument = argument
        self.findMealDetailUsecase = findMealDetailUsecase
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
    
}
