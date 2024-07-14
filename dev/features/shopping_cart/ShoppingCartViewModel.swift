import Foundation
import SwiftUI

class ShoppingCartViewModel: ObservableObject {
    private let navigator: NavigationCoordinator;
    
    init(
        navigator: NavigationCoordinator
    ) {
        self.navigator = navigator
    }
}
