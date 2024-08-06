//
//  DatasouceDependencyInjection.swift
//  dev
//
//  Created by phan dam tung lam on 14/7/24.
//

import Foundation

class DatasoucesDependencyInjection {
    
    var networkService: NetworkServiceContract;
    var authorizationLocalStorage: AuthenticationLocalStorage;
    
    init(networkService: NetworkServiceContract, authorizationLocalStorage: AuthenticationLocalStorage) {
        self.networkService = networkService
        self.authorizationLocalStorage = authorizationLocalStorage
    }
    
    private(set) lazy var getFoodDataSourceRemoteContract = FoodDataSourceRemote(
        networkContract: self.networkService
    );
    
    private(set) lazy var getFoodDataSourceLocalContract = FoodDataSourceLocal()

    private(set) lazy var getUserDataSourceRemoteContract = UserDataSourceRemote(
        networkContract: self.networkService,
        authenticationLocalStorage: self.authorizationLocalStorage
    );
    
    private(set) lazy var getUserDataSourceLocalContract = UserDataSourceLocal()
    
    private(set) lazy var getBasketDataSourceRemoteContract = BasketDataSourceRemote(
        networkContract: self.networkService,
        authenticationLocalStorage: self.authorizationLocalStorage
    );
    
    private(set) lazy var getBasketDataSourceLocalContract = BasketDataSourceLocal()
    
    private(set) lazy var paymentDataSourceLocalContract = PaymentDataSourceRemote(
        networkContract: self.networkService,
        authenticationLocalStorage: self.authorizationLocalStorage
    )
}
