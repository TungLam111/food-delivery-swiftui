import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    private let navigator: NavigationCoordinator;
    
    init(
        navigator: NavigationCoordinator
    ) {
        self.navigator = navigator
    }
}
