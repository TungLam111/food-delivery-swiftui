import Foundation
import SwiftUI

class CheckoutViewModel: ObservableObject {
    private let navigator: NavigationCoordinator;
    
    init(
        navigator: NavigationCoordinator
    ) {
        self.navigator = navigator
    }
}
