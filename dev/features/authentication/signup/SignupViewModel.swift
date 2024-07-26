
import Foundation
import SwiftUI

class SignupViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var phone: String = ""
    @Published var repeatPassword = ""
    @Published var name = ""
    
    @Published var showError: Bool = false
    @Published var errorMessage: String? = nil
    
    @Published var isPasswordVisible: Bool = true
    @Published var isRepeatPasswordVisible: Bool = true
    
    @Published var acceptTerm : Bool = true
    
    private let navigator: NavigationCoordinator;
    private let createAccountUsecase: CreateAccountUsecase;
    private let argument: AuthenticationArgs?;
    
    init(
        navigator: NavigationCoordinator,
        argument: AuthenticationArgs?,
        createAccountUsecase: CreateAccountUsecase
    ) {
        self.navigator = navigator
        self.argument = argument
        self.createAccountUsecase = createAccountUsecase
    }
    
    func singup() {
        DispatchQueue.main.async{
            Task {
                do {
                    guard self.acceptTerm == true else {
                        self.errorMessage = "You have to agree with the terms and conditions"
                        return
                    }
                    
                    guard !self.email.isEmpty, !self.password.isEmpty, !self.phone.isEmpty, !self.repeatPassword.isEmpty, !self.name.isEmpty else {
                        self.errorMessage = "Fields cannot be empty"
                        self.showError = true
                        return
                    }
                    
                    guard self.password == self.repeatPassword else {
                        self.errorMessage = "Password does not match"
                        return
                    }
                    
                    self.showError = false
                    self.errorMessage = nil
                    
                    let result : DataState<SignupDataResponse?> = try await self.createAccountUsecase.execute(dto: CreateAccoutDto(
                        email: self.email, password: self.password, phoneNumber: self.phone, name: self.name))
                    
                    if (result.isError) {
                        
                    } else {
                        self.navigator.pushAndRemoveLast(RootViewModel.Destination.login(vm: DependencyInjector.instance.viewModelsDI.login(navigationCoordinator: self.navigator)))
                    }
                    
                } catch {
                    print("Error: \(error)")
                }
            }
        }
        
        
    }
    
    func onBack(){
        self.navigator.popLast()
    }
}
