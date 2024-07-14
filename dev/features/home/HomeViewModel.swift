import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    let navigator: NavigationCoordinator;
    
    init(
        navigator: NavigationCoordinator
    ) {
        self.navigator = navigator
    }
    
    @Published var currentTab: HomeTab = HomeTab.top;
}
