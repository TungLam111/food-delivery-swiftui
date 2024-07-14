//
//  AuthenticationViewModel.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import Foundation
import SwiftUI

class AuthenticationViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var enableButton: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String? = nil
    @Published var selectedTab : AuthenticationType = AuthenticationType.login
    
    private let navigator: NavigationCoordinator;
    private let argument: AuthenticationArgs?;
    
    init(
        navigator: NavigationCoordinator,
        argument: AuthenticationArgs?
    ) {
        
        self.navigator = navigator
        self.argument = argument
    }
    
    func login() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password cannot be empty"
            showError = true
            enableButton = false
            return
        }
        
        showError = false
        errorMessage = nil
        enableButton = true
        
        navigator.push(RootViewModel.Destination.home(
            vm: DependencyInjector.instance.viewModelsDI.home(
                navigationCoordinator: self.navigator)))
        
    }
    
    func onChangeEmail(email: String) {
        if (email.isEmpty) {
            errorMessage = "Email cant not be empty"
            showError = true
            enableButton = false
            return;
        }
        
        if (password.isEmpty) {
            errorMessage = nil
            showError = false
            enableButton = false
            return;
        }
        
        enableButton = true
        showError = false
        errorMessage = nil
    }
    
    func onChangePassword(password: String) {
        if (password.isEmpty) {
            errorMessage = "Password cant not be empty"
            showError = true
            enableButton = false
            return;
        }
        
        if (email.isEmpty) {
            errorMessage = nil
            showError = false
            enableButton = false
            return;
        }
        
        enableButton = true
        showError = false
        errorMessage = nil
        
    }
}
