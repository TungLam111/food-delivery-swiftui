//
//  LandingViewModel.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import Foundation

class LandingViewModel : ObservableObject {
    private let navigator: NavigationCoordinator;
    
    init(
        navigator: NavigationCoordinator
    ) {
     
        self.navigator = navigator
    }
    
    func navToAuthentication(){
        self.navigator.push(RootViewModel.Destination.authentication(
            vm: DependencyInjector.instance.viewModelsDI.authentication(navigationCoordinator: self.navigator)))
    }
}
