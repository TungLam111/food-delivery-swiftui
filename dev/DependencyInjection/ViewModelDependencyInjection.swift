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
            addToShoppingBasketUsecase: usecasesDI.addToShoppingBasket,
            shoppingCartLocalStorage: ShoppingCartLocalStorage(sharedPrefs: UserDefaults.standard),
            findOneBasketUsecase: usecasesDI.getOneBasketUsecase,
            argument: args
        )
    }
    
    func checkout(navigationCoordinator: NavigationCoordinator) -> CheckoutViewModel{
        return CheckoutViewModel(
            navigator: navigationCoordinator,
            getPaymentMethodsUsecase: usecasesDI.getPaymentMethod,
            getPaymentCardsUsecase: usecasesDI.getPaymentCards,
            addPaymentCardUsecase: usecasesDI.addPaymentCard,
            payCompleteUsecase: usecasesDI.payComplete,
            removePaymentCardUsecase: usecasesDI.removePaymentCard,
            getLocationsUsecase: usecasesDI.getLocation,
            addLocationUsecase: usecasesDI.addLocation
        )
    }
    
    func shoppingCart(navigationCoordinator: NavigationCoordinator) -> ShoppingCartViewModel{
        return ShoppingCartViewModel(
            navigator: navigationCoordinator,
                                     shoppingCartLocalStorage: ShoppingCartLocalStorage(sharedPrefs: UserDefaults.standard),
            getBasketListUsecase: self.usecasesDI.getBasketListUsecase,
            updateBasketUsecase: self.usecasesDI.updateShoppingBasket,
            deleteBasketUsecase: self.usecasesDI.deleteBasketUsecase
        )
    }
    
    func login(navigationCoordinator: NavigationCoordinator) -> LoginViewModel{
        return LoginViewModel(
            navigator: navigationCoordinator,
            argument: nil,
            loginUsecase: self.usecasesDI.loginUsecase,
            authenLocalStorage: AuthenticationLocalStorage(defaults: UserDefaults.standard)
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
