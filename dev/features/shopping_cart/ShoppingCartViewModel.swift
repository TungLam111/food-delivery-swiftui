import Foundation
import SwiftUI

class ShoppingCartViewModel: ObservableObject {
    private let navigator: NavigationCoordinator;
    
    @Published  var verticalOffsetScrolling =  CGSize.zero;
    @Published var cartItems : [CartItem] = []
    
    var shoppingCartLocalStorage: ShoppingCartLocalStorage<[CartItem]?>;
    
    init(
        navigator: NavigationCoordinator,
        shoppingCartLocalStorage: ShoppingCartLocalStorage<[CartItem]?>
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
                self.cartItems = (data ?? []) ?? [];
                if (self.cartItems.isEmpty) {
                    let saveOk : Bool =  self.shoppingCartLocalStorage.save([
                        CartItem(imageName: "user_avatar", name: "Veggie tomato mix", price: "₦1,900", quantity: 1),
                        CartItem(imageName: "user_avatar", name: "Fishwith mix orange....", price: "₦1,900", quantity: 1),
                        CartItem(imageName: "user_avatar", name: "Veggie tomato mix", price: "₦1,900", quantity: 1),
                        CartItem(imageName: "user_avatar", name: "Veggie tomato mix", price: "₦1,900", quantity: 1),
                        CartItem(imageName: "user_avatar", name: "Veggie tomato mix", price: "₦1,900", quantity: 1),
                        CartItem(imageName: "user_avatar", name: "Veggie tomato mix", price: "₦1,900", quantity: 1),
                        CartItem(imageName: "user_avatar", name: "Veggie tomato mix", price: "₦1,900", quantity: 1),
                        CartItem(imageName: "user_avatar", name: "Veggie tomato mix", price: "₦1,900", quantity: 1),
                        CartItem(imageName: "user_avatar", name: "Veggie tomato mix", price: "₦1,900", quantity: 1),
                        CartItem(imageName: "user_avatar", name: "Veggie tomato mix", price: "₦1,900", quantity: 1),
                        CartItem(imageName: "user_avatar", name: "Veggie tomato mix", price: "₦1,900", quantity: 1),
                        CartItem(imageName: "user_avatar", name: "Veggie tomato mix", price: "₦1,900", quantity: 1)
                    ])
                    
                    if saveOk {
                        self.cartItems = (self.shoppingCartLocalStorage.load() ?? []) ?? []
                    }
                }
            }
        }
    }
    
    func onBack() {
        self.navigator.popLast()
    }
    
    func onRemove(item: CartItem){
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            cartItems.remove(at: index)
            _ = self.shoppingCartLocalStorage.save(cartItems)
        }
    }
    
    func onAdd(id: UUID) {
        if let index = cartItems.firstIndex(where: { $0.id == id }) {
            cartItems[index].quantity += 1;
            _ = self.shoppingCartLocalStorage.save(cartItems)
        }
    }
    
    func onSubtract(id: UUID) {
            if let index = cartItems.firstIndex(where: { $0.id == id }) {
                if cartItems[index].quantity == 1 {
                    cartItems.remove(at: index)
                } else {
                    cartItems[index].quantity -= 1;
                }
                
                _ = self.shoppingCartLocalStorage.save(cartItems)
            }
        

    }
}
