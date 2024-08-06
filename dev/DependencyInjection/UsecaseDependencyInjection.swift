//
//  UsecaseDependencyInjection.swift
//  dev
//
//  Created by phan dam tung lam on 14/7/24.
//

import Foundation

class UsecasesDependencyInjection {
    var repositoriesDI: RepositoriesDependencyInjection
    init(repositoriesDI: RepositoriesDependencyInjection) {
        self.repositoriesDI = repositoriesDI
    }
    
    private(set) lazy var  findFoodByCategory = FindFoodByCategoryUsecase(
        foodRepository: self.repositoriesDI.foodRepository
    );
    
    private(set) lazy var findAllCategories = FindAllCategoriesUsecase(
        foodRepository: self.repositoriesDI.foodRepository 
    );
    
    private(set) lazy var findMealDetail =  FindMealDetailUsecase(
        foodRepository: self.repositoriesDI.foodRepository   
    );
    
    private(set) lazy var searchMealsByName =  SearchByTextUsecase(
        foodRepository: self.repositoriesDI.foodRepository
    );
    
    private(set) lazy var loginUsecase =  LoginUsecase(
        userRepository: self.repositoriesDI.userRepository
    );
    
    private(set) lazy var signupUsecase =  CreateAccountUsecase(
        userRepository: self.repositoriesDI.userRepository
    );
    
    private(set) lazy var addToShoppingBasket =  AddToShoppingBasketUsecase(
        basketRepository: self.repositoriesDI.basketRepository
    );
    
    private(set) lazy var updateShoppingBasket =  UpdateBasketUsecase(
        basketRepository: self.repositoriesDI.basketRepository
    );
    
    private(set) lazy var getBasketListUsecase =  GetBasketListUsecase(
        basketRepository: self.repositoriesDI.basketRepository
    );
    
    private(set) lazy var deleteBasketUsecase =  DeleteBasketUsecase(
        basketRepository: self.repositoriesDI.basketRepository
    );
    
    private(set) lazy var getOneBasketUsecase =  FindOneBasketUsecase(
        basketRepository: self.repositoriesDI.basketRepository
    );
    
    private(set) lazy var removePaymentCard =  RemovePaymentCardUsecase(
        paymentRepository: self.repositoriesDI.paymentRepository
    );
    
    private(set) lazy var getPaymentMethod =  GetPaymentMethodUsecase(
        paymentRepository: self.repositoriesDI.paymentRepository
    );
    
    private(set) lazy var getPaymentCards =  GetPaymentCardsUsecase(
        paymentRepository: self.repositoriesDI.paymentRepository
    );
    
    private(set) lazy var addPaymentCard =  AddPaymentCardUsecase(
        paymentRepository: self.repositoriesDI.paymentRepository
    );
    
    private(set) lazy var payComplete =  PaymentCompleteUsecase(
        paymentRepository: self.repositoriesDI.paymentRepository
    );
    
    private(set) lazy var getLocation =  GetLocationUsecase(
        paymentRepository: self.repositoriesDI.paymentRepository
    );
    
    private(set) lazy var addLocation =  AddLocationUsecase(
        paymentRepository: self.repositoriesDI.paymentRepository
    );
}
