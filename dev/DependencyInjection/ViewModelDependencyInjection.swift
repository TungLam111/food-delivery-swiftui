//
//  ViewModelDependencyInjection.swift
//  dev
//
//  Created by phan dam tung lam on 14/7/24.
//

import Foundation

final class ViewModelsDependencyInjector  {
    var usecasesDI: UsecasesDependencyInjection;
    
    init(usecasesDI: UsecasesDependencyInjection) {
        self.usecasesDI = usecasesDI
    }
    
    func landing(navigationCoordinator: NavigationCoordinator) -> LandingViewModel {
        return LandingViewModel(navigator: navigationCoordinator)
    }
    
    func authentication(navigationCoordinator: NavigationCoordinator) -> AuthenticationViewModel{
        return AuthenticationViewModel(
            navigator: navigationCoordinator,
            argument: nil
        )
    }
    
    func top(navigationCoordinator: NavigationCoordinator) -> TopViewModel {
        return TopViewModel(
            navigator: navigationCoordinator,
            findAllCategoriesUsecase: usecasesDI.findAllCategories,
            findFoodByCategoryUsecase: usecasesDI.findFoodByCategory
        )
    }
    
    func home(navigationCoordinator: NavigationCoordinator) -> HomeViewModel {
        return HomeViewModel(navigator: navigationCoordinator)
    }
    
    func history(navigationCoordinator: NavigationCoordinator) -> HistoryViewModel {
        return HistoryViewModel(navigator: navigationCoordinator)
    }
    
    func order(navigationCoordinator: NavigationCoordinator) -> OrderViewModel {
        return OrderViewModel(navigator: navigationCoordinator)
    }
    
    func seach(navigationCoordinator: NavigationCoordinator) -> SearchViewModel {
        return SearchViewModel(navigator: navigationCoordinator)
    }
    
    func profile(navigationCoordinator: NavigationCoordinator) -> ProfileViewModel {
        return ProfileViewModel(navigator: navigationCoordinator)
    }
    
    
    func dishDetail(navigationCoordinator: NavigationCoordinator, args: DishDetailArgs) -> DishDetailViewModel {
        return DishDetailViewModel(
            navigator: navigationCoordinator,
            findMealDetailUsecase: usecasesDI.findMealDetail,
            argument: args
        )
    }
    
    func checkout(navigationCoordinator: NavigationCoordinator) -> CheckoutViewModel{
        return CheckoutViewModel(navigator: navigationCoordinator)
    }
    
    func shoppingCart(navigationCoordinator: NavigationCoordinator) -> ShoppingCartViewModel{
        return ShoppingCartViewModel(navigator: navigationCoordinator)
    }
}
