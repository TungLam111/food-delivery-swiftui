import Foundation
import SwiftUI

class HistoryViewModel: ObservableObject {
    private let navigator: NavigationCoordinator;
    @Published var historyItems: [MealDetail] = [];
    
    private var searchByTextUsecase: SearchByTextUsecase;
        
    init(
        navigator: NavigationCoordinator,
        searchByTextUsecase: SearchByTextUsecase
    ) {
        self.navigator = navigator
        self.searchByTextUsecase = searchByTextUsecase
        
        setup()
    }
    
    func setup(){
        onSearching(text: "viet")
    }
        
    func onBack(){
        self.navigator.popLast()
    }
    
    func onSearching(text: String) {
        print(text)
        DispatchQueue.main.async{
            Task {
                do {
                    let data = try await self.searchByTextUsecase.execute(text: text)
                    self.historyItems = data?.meals ?? [];
                } catch {
                    // Handle error if needed
                    print("Error fetching meals: \(error)")
                }
            }
        }
    }
    
    func navToMealDetail(dishId: String) {
        self.navigator.push(RootViewModel.Destination.dishDetail(
            vm:
                DependencyInjector.instance.viewModelsDI.dishDetail(navigationCoordinator: self.navigator, args: DishDetailArgs(id: dishId, basketId: nil))
        ))
    }
}
