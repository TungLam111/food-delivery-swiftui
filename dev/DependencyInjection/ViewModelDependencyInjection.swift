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
            findFoodByCategoryUsecase: usecasesDI.findFoodByCategory,
            shoppingCartLocalStorage: ShoppingCartLocalStorage(sharedPrefs: UserDefaults.standard)
        )
    }
    
    func home(navigationCoordinator: NavigationCoordinator) -> HomeViewModel {
        return HomeViewModel(navigator: navigationCoordinator)
    }
    
    func history(navigationCoordinator: NavigationCoordinator) -> HistoryViewModel {
        return HistoryViewModel(
            navigator: navigationCoordinator,
            searchByTextUsecase: usecasesDI.searchMealsByName
        )
    }
    
    func order(navigationCoordinator: NavigationCoordinator) -> OrderViewModel {
        return OrderViewModel(navigator: navigationCoordinator, searchByTextUsecase: usecasesDI.searchMealsByName)
    }
    
    func seach(navigationCoordinator: NavigationCoordinator) -> SearchViewModel {
        return SearchViewModel(navigator: navigationCoordinator,
                               searchByTextUsecase: usecasesDI.searchMealsByName)
    }
    
    func profile(navigationCoordinator: NavigationCoordinator) -> ProfileViewModel {
        return ProfileViewModel(navigator: navigationCoordinator)
    }
    
    
    func dishDetail(navigationCoordinator: NavigationCoordinator, args: DishDetailArgs) -> DishDetailViewModel {
        return DishDetailViewModel(
            navigator: navigationCoordinator,
            findMealDetailUsecase: usecasesDI.findMealDetail,
            shoppingCartLocalStorage: ShoppingCartLocalStorage(sharedPrefs: UserDefaults.standard),
            argument: args
        )
    }
    
    func checkout(navigationCoordinator: NavigationCoordinator) -> CheckoutViewModel{
        return CheckoutViewModel(navigator: navigationCoordinator)
    }
    
    func shoppingCart(navigationCoordinator: NavigationCoordinator) -> ShoppingCartViewModel{
        return ShoppingCartViewModel(navigator: navigationCoordinator,
                                     shoppingCartLocalStorage: ShoppingCartLocalStorage(sharedPrefs: UserDefaults.standard)
        )
    }
    
    func login(navigationCoordinator: NavigationCoordinator) -> LoginViewModel{
        return LoginViewModel(
            navigator: navigationCoordinator,
            argument: nil,
            loginUsecase: self.usecasesDI.loginUsecase
        )
    }
    
    func signup(navigationCoordinator: NavigationCoordinator) -> SignupViewModel{
        return SignupViewModel(
            navigator: navigationCoordinator,
            argument: nil,
            createAccountUsecase: usecasesDI.signupUsecase
        )
    }

}
