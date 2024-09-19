import Foundation
import SwiftUI
import Combine

struct CouponModel {
    var name: String;
    var timeStart: Date;
    var timeEnd: Date;
    var content: String;
    var type: CouponType;
}

class TopViewModel: BaseViewModel {
    private let navigator: NavigationCoordinator;
    var findFoodByCategoryUsecase: FindFoodByCategoryUsecase;
    var findAllCategoriesUsecase: FindAllCategoriesUsecase;
    var shoppingCartLocalStorage: ShoppingCartLocalStorage;
    
    @Published var currentCategory : String = "Beef"
    @Published var categories: [CategoryFoodModel]? = []
    @Published var mealsByCategory: [MealDetail]? = []
    @Published var cartItems: [AddCartItem] = []
    
    @Published var currentCouponIndex = 0
    @Published var couponList : [CouponModel] = [
        CouponModel(
            name: "For all Espresso",
            timeStart: Date.now,
            timeEnd: Date.now,
            content: "Fee for all",
            type: CouponType.sale
        ),
        CouponModel(
            name: "Free Delivery",
            timeStart: Date.now,
            timeEnd: Date.now,
            content: "Fee for all",
            type: CouponType.freeShip
        ),
        CouponModel(
            name: "For all Espresso",
            timeStart: Date.now,
            timeEnd: Date.now,
            content: "Buy 1 Get 1 Extra Gift",
            type: CouponType.gift
        )
    ]
    
    var cancellables = Set<AnyCancellable>()
    var isLoadingContent: CurrentValueSubject<Bool, Never> = .init(false)
    
    init(
        navigator: NavigationCoordinator,
        findAllCategoriesUsecase: FindAllCategoriesUsecase,
        findFoodByCategoryUsecase: FindFoodByCategoryUsecase,
        shoppingCartLocalStorage: ShoppingCartLocalStorage
    ) {
        
        self.navigator = navigator
        self.findAllCategoriesUsecase = findAllCategoriesUsecase
        self.findFoodByCategoryUsecase = findFoodByCategoryUsecase
        self.shoppingCartLocalStorage = shoppingCartLocalStorage
        super.init()
        
        setup()
    }
    
    func setup() {
        findAllCategories();
        findFoodByCategory(category: "Beef");
        getSavedShoppingCarts();
    }
    
    func findAllCategories() {
        guard !isLoadingContent.value else { return }
        isLoadingContent.send(true)
        self.findAllCategoriesUsecase.execute()
            .replaceError(with: nil)
            .share()
            .subscribe(on: DispatchQueue(label: "backgroundQueue"))
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] _ in
                    self?.isLoadingContent.send(false)
                }) { [weak self] categoriesData in
                    self?.categories = categoriesData?.categories;
                }.store(in: &cancellables)
        return;
    }
    
    func findFoodByCategory(category: String) {
        currentCategory = category;
        DispatchQueue.main.async{
            Task {
                self.mainLoadingStatus.toggle()
                do {
                    let data = try await self.findFoodByCategoryUsecase.execute(category: category)
                    self.mealsByCategory = data?.meals?.map({ meal in
                        return meal.initPriceAndQuantity()
                    });
                    self.mainLoadingStatus.toggle()
                } catch {
                    // Handle error if needed
                    print("Error fetching meals: \(error)")
                    self.mainLoadingStatus.toggle()
                }
            }
        }
    }
    
    func getSavedShoppingCarts() {
        DispatchQueue.main.async{
            Task {
                let data = self.shoppingCartLocalStorage.load()
                self.cartItems = data ?? self.cartItems;
            }
        }
    }
    
    
    func navToMealDetail(dishId: String) {
        self.navigator.push(RootViewModel.Destination.dishDetail(
            vm:
                DependencyInjector.instance.viewModelsDI.dishDetail(navigationCoordinator: self.navigator, args: DishDetailArgs(id: dishId, basketId: nil))
        ))
    }
    
    func navToSearch() {
        self.navigator.push(RootViewModel.Destination.search(vm: DependencyInjector.instance.viewModelsDI.seach(navigationCoordinator: self.navigator)))
    }
    
    func navToShoppingCart() {
        self.navigator.push(RootViewModel.Destination.shoppingCart(vm: DependencyInjector.instance.viewModelsDI.shoppingCart(navigationCoordinator: self.navigator)))
    }
}
