import Foundation
import SwiftUI

class ShoppingCartViewModel: ObservableObject {
    private let navigator: NavigationCoordinator;
    
    @Published  var verticalOffsetScrolling =  CGSize.zero;
    @Published var cartItems : [CartItem] = []
    
    var shoppingCartLocalStorage: ShoppingCartLocalStorage;
    
    init(
        navigator: NavigationCoordinator,
        shoppingCartLocalStorage: ShoppingCartLocalStorage
    ) {
        self.navigator = navigator
        self.shoppingCartLocalStorage = shoppingCartLocalStorage
        
        setup();
    }
    
    func setup() {
        getSavedShoppingCarts()
    }
    
    func getSavedShoppingCarts() {
        DispatchQueue.main.async{
            Task {
                let data = self.shoppingCartLocalStorage.load()
                self.cartItems = data ?? [];
            }
        }
    }
    
    func onBack() {
        self.navigator.popLast()
    }
    
    func onRemove(item: CartItem){
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            _ = self.shoppingCartLocalStorage.removeOne(by: cartItems[index])
            cartItems.remove(at: 0)
        }
    }
    
    func onAdd(id: String) {
        if let index = cartItems.firstIndex(where: { $0.id == id }) {
            _ = self.shoppingCartLocalStorage.saveOne(cartItems[index])
            cartItems[index].quantity += 1;
        }
    }
    
    func onSubtract(id: String) {
            if let index = cartItems.firstIndex(where: { $0.id == id }) {
                _ = self.shoppingCartLocalStorage.removeOne(by: cartItems[index])

                if cartItems[index].quantity == 1 {
                    cartItems.remove(at: index)
                } else {
                    cartItems[index].quantity -= 1;
                }
        }
    }
}
