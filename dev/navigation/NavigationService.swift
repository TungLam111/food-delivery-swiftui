//
//  NavigationService.swift
//  dev
//
//  Created by phan dam tung lam on 8/7/24.
//

import Foundation
import SwiftUI


final class RootViewModel: ObservableObject, Identifiable {
    
    public enum Destination: Hashable {
        case landing(vm: LandingViewModel)
        case authentication(vm: AuthenticationViewModel)
        case home(vm: HomeViewModel)
        case history(vm: HistoryViewModel)
        case order(vm: OrderViewModel)
        case profile(vm: ProfileViewModel)
        case search(vm: SearchViewModel)
        case dishDetail(vm: DishDetailViewModel)
        case checkout(vm: CheckoutViewModel)
        case shoppingCart(vm: ShoppingCartViewModel)
        case login(vm: LoginViewModel)
        case signup(vm: SignupViewModel)
        
        func hash(into hasher: inout Hasher) {
            var index = 0
            switch self {
            case .landing:
                index = 0
            case .authentication:
                index = 1
            case .home:
                index = 2
            case .history:
                index = 3
            case .order:
                index = 4
            case .profile:
                index = 5
            case .search:
                index = 6
            case .dishDetail:
                index = 7
            case .checkout:
                index = 8
            case .shoppingCart:
                index = 9
            case .login:
                index = 10
            case .signup:
                index = 11
            }
            hasher.combine(index)
        }
        
        static func == (
            lhs: Destination,
            rhs: Destination
          ) -> Bool {
            lhs.hashValue == rhs.hashValue
          }
    }
    
    @Published var navPath = NavigationPath()
    
    /// The ViewModel that represents our first view in the navigation stack
    public lazy var firstContentViewModel: LandingViewModel = {
        .init(navigator: self)
    }()
    
    public lazy var firstHomeView: HomeViewModel = {
        .init(navigator: self)
    }()
        
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}


extension RootViewModel : NavigationCoordinator {
    func pushAndRemoveLast(_ path: any Hashable) {
        DispatchQueue.main.async { [weak self] in
            self?.navPath.removeLast()
            self?.navPath.append(path)
        }
    }
    
    public func push(_ path: any Hashable) {
           DispatchQueue.main.async { [weak self] in
               self?.navPath.append(path)
           }
       }

       public func popLast() {
           DispatchQueue.main.async { [weak self] in
               self?.navPath.removeLast()
           }
       }
}


public protocol NavigationCoordinator {
    func push(_ path: any Hashable)
    func popLast()
    func pushAndRemoveLast(_ path: any Hashable)
}
