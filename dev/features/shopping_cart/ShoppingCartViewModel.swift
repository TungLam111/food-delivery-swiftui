import Foundation
import SwiftUI

class ShoppingCartViewModel: BaseViewModel {
    private let navigator: NavigationCoordinator;
    
    @Published var verticalOffsetScrolling =  CGSize.zero;
    @Published var cartItems : [BasketItemResponse] = []
    @Published var basketPricingData : BasketPricingData? = nil;
    
    var shoppingCartLocalStorage: ShoppingCartLocalStorage;
    var getBasketListUsecase: GetBasketListUsecase;
    var updateBasketUsecase: UpdateBasketUsecase;
    var deleteBasketUsecase: DeleteBasketUsecase;
    
    init(
        navigator: NavigationCoordinator,
        shoppingCartLocalStorage: ShoppingCartLocalStorage,
        getBasketListUsecase: GetBasketListUsecase,
        updateBasketUsecase: UpdateBasketUsecase,
        deleteBasketUsecase: DeleteBasketUsecase
    ) {
        self.navigator = navigator
        self.shoppingCartLocalStorage = shoppingCartLocalStorage
        self.getBasketListUsecase = getBasketListUsecase
        self.updateBasketUsecase = updateBasketUsecase
        self.deleteBasketUsecase = deleteBasketUsecase
        
        super.init()
        
        setup();
    }
    
    func setup() {
        getSavedShoppingCarts()
    }
    
    func getSavedShoppingCarts() {
        DispatchQueue.main.async {
            Task {
                self.mainLoadingStatus.toggle()
                do {
                    let result : DataState<BasketListResponse?> = try await self.getBasketListUsecase.execute()
                    
                    if result.isSuccess {
                        self.cartItems = result.data??.results ?? []
                        self.basketPricingData = BasketPricingData(
                            foodPrice: result.data??.foodPrice ?? 0,
                            totalPrice: result.data??.totalPrice ?? 0,
                            deliveryPrice: result.data??.deliveryPrice ?? 0
                        )
                    }
                    self.mainLoadingStatus.toggle()
                } catch {
                    self.mainLoadingStatus.toggle()
                }
            }
        }
    }
    
    func getShoppingBaskets() async throws -> ([BasketItemResponse]?, BasketPricingData?) {
            let result : DataState<BasketListResponse?> = try await self.getBasketListUsecase.execute()
            
            if result.isSuccess {
                return (result.data??.results ?? [],BasketPricingData(
                    foodPrice: result.data??.foodPrice ?? 0,
                    totalPrice: result.data??.totalPrice ?? 0,
                    deliveryPrice: result.data??.deliveryPrice ?? 0
                ) )
            }
        
        return (nil, nil)
    }
    
    func _updateBasket(dto: UpdateBasketItem) async throws -> BasketItemResponse? {
        do {
            let result : DataState<BasketItemResponse?> = try await self.updateBasketUsecase.execute(dto: dto)
            if result.isSuccess {
                return result.data ?? nil;
            }
        } catch {
            print(error)
            return nil
        }
        return nil
    }
    
    func _removeBasket(basketId: String) async throws -> BasketItemResponse? {
        do {
            let result : DataState<BasketItemResponse?> = try await self.deleteBasketUsecase.execute(basketId: basketId)
            if result.isSuccess {
                return result.data ?? nil;
            }
        } catch {
            print(error)
            return nil;
        }
        return nil
    }
    
    func onBack() {
        self.navigator.popLast()
    }
    
    func onRemove(item: BasketItemResponse) {
        DispatchQueue.main.async{
            Task {
                self.mainLoadingStatus.toggle()
                let _ = try await self._removeBasket(basketId: item.id)
                 let (a, b) = try await self.getShoppingBaskets();
                self.cartItems = a ?? []
                self.basketPricingData = b
                
                self.mainLoadingStatus.toggle()
            }
        }
    }
    
    func onAdd(id: String) {
        DispatchQueue.main.async{
            Task {
                self.mainLoadingStatus.toggle()

                if let index = self.cartItems.firstIndex(where: { $0.id == id }) {
                    // TODO handle API
                    self.cartItems[index].quantity += 1;
                    
                    let data = try await self._updateBasket(dto: UpdateBasketItem(
                        id: self.cartItems[index].id,
                        mealId: self.cartItems[index].mealId,
                        price: self.cartItems[index].price,
                        quantity: self.cartItems[index].quantity,
                        topping: self.cartItems[index].topping,
                        userId: self.cartItems[index].userId,
                        mealName: self.cartItems[index].mealName,
                        mealCategory: self.cartItems[index].mealCategory,
                        mealImage: self.cartItems[index].mealImage
                      )
                    )
                    
                    if data != nil {
                        let (a, b) = try await self.getShoppingBaskets();
                        self.cartItems = a ?? []
                        self.basketPricingData = b
                    }
                    self.mainLoadingStatus.toggle()
                }
            }
        }
    }
    
    func onSubtract(id: String) {
        DispatchQueue.main.async {
            Task {
                self.mainLoadingStatus.toggle()
                if let index = self.cartItems.firstIndex(where: { $0.id == id }) {
                    if self.cartItems[index].quantity == 1 {
                        self.onRemove(item: self.cartItems[index])
                    } else {
                        self.cartItems[index].quantity -= 1;
                        let data = try await self._updateBasket(dto: UpdateBasketItem(
                            id: self.cartItems[index].id,
                            mealId: self.cartItems[index].mealId,
                            price: self.cartItems[index].price,
                            quantity: self.cartItems[index].quantity,
                            topping: self.cartItems[index].topping,
                            userId: self.cartItems[index].userId,
                            mealName: self.cartItems[index].mealName,
                            mealCategory: self.cartItems[index].mealCategory,
                            mealImage: self.cartItems[index].mealImage
                          )
                        )
                        if data != nil {
                            let (a, b) = try await self.getShoppingBaskets();
                            self.cartItems = a ?? []
                            self.basketPricingData = b
                        }
                    }
                }
                self.mainLoadingStatus.toggle()
            }
        }
    }
    
    func onTap(dish: BasketItemResponse) {
        self.navigator.push(RootViewModel.Destination.dishDetail(
            vm: DependencyInjector.instance.viewModelsDI.dishDetail(
                navigationCoordinator: self.navigator,
                args: DishDetailArgs(
                    id: dish.mealId,
                    basketId: dish.id
                )
            )
          )
       )
    }
    
    func buyNow() {
        self.navigator.push(RootViewModel.Destination.checkout(
            vm:
                DependencyInjector.instance.viewModelsDI.checkout(navigationCoordinator: self.navigator)
           )
        )
    }
}

