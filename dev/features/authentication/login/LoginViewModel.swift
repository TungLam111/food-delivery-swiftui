
import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var enableButton: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String? = nil
    @Published var rememberMe: Bool = false
    @Published var isPasswordVisible: Bool = true;
    
    private let navigator: NavigationCoordinator;
    private let argument: AuthenticationArgs?;
    private let loginUsecase: LoginUsecase;
    
    init(
        navigator: NavigationCoordinator,
        argument: AuthenticationArgs?,
        loginUsecase: LoginUsecase
    ) {
        self.navigator = navigator
        self.argument = argument
        self.loginUsecase = loginUsecase
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
        
        DispatchQueue.main.async {
            Task {
                do {
                    let result : DataState<LoginDataResponse?> = try await self.loginUsecase.execute(dto: LoginDto(email: self.email, password: self.password))
                    
                    if result.isError {
                        return
                    }
                    self.navigator.push(RootViewModel.Destination.home(
                        vm: DependencyInjector.instance.viewModelsDI.home(
                            navigationCoordinator: self.navigator)))
                }
            }
        }
        
        
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
    
    
    func navToSignup() {
        navigator.push(RootViewModel.Destination.signup(
            vm: DependencyInjector.instance.viewModelsDI.signup(
                navigationCoordinator: self.navigator)))
    }
    
    func onBack() {
        self.navigator.popLast()
    }
}
