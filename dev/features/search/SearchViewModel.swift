import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    private let navigator: NavigationCoordinator;
    private var searchByTextUsecase: SearchByTextUsecase;
    
    @Published var mealsByCategory: [MealDetail] = []
    
    init(
        navigator: NavigationCoordinator,
        searchByTextUsecase: SearchByTextUsecase
    ) {
        self.navigator = navigator
        self.searchByTextUsecase = searchByTextUsecase
        
        setup()
    }
    
    func setup(){
        onSearching(text: "a")
    }
    
    @Published var searchText = ""
    
    func onBack(){
        self.navigator.popLast()
    }
    
    func onSearching(text: String) {
        print(text)
        DispatchQueue.main.async{
            Task {
                do {
                    let data = try await self.searchByTextUsecase.execute(text: text)
                    self.mealsByCategory = data?.meals ?? [];
                } catch {
                    // Handle error if needed
                    print("Error fetching meals: \(error)")
                }
            }
        }
    }
}
