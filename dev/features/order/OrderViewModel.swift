import Foundation
import SwiftUI

class OrderViewModel: ObservableObject {
    private let navigator: NavigationCoordinator;
    
    init(
        navigator: NavigationCoordinator
    ) {
        self.navigator = navigator
    }
}
