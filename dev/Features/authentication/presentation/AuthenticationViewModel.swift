//
//  AuthenticationViewModel.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import Foundation
import SwiftUI

class AuthenticationViewModel: ObservableObject {
        
    private let navigator: NavigationCoordinator;
    private let argument: AuthenticationArgs?;
    
    init(
        navigator: NavigationCoordinator,
        argument: AuthenticationArgs?
    ) {
        
        self.navigator = navigator
        self.argument = argument
    }
    
    func navLogin() {
        self.navigator.push(RootViewModel.Destination.login(
            vm:
                DependencyInjector.instance.viewModelsDI.login(navigationCoordinator: self.navigator)
        ))
    }
    
    func navSignup() {
        self.navigator.push(RootViewModel.Destination.signup(
            vm:
                DependencyInjector.instance.viewModelsDI.signup(navigationCoordinator: self.navigator)
        ))
    }
    
    func connectFacebook() {
        
    }
    
    func connectGoogle() {
        
    }
}
