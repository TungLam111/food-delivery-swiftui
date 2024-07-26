//
//  DatasouceDependencyInjection.swift
//  dev
//
//  Created by phan dam tung lam on 14/7/24.
//

import Foundation

class DatasoucesDependencyInjection {
    
    var networkService: NetworkServiceContract;
    
    init(networkService: NetworkServiceContract) {
        self.networkService = networkService
    }
    
    private(set) lazy var getFoodDataSourceRemoteContract = FoodDataSourceRemote(
        networkContract: self.networkService
    );
    
    private(set) lazy var getFoodDataSourceLocalContract = FoodDataSourceLocal()

    private(set) lazy var getUserDataSourceRemoteContract = UserDataSourceRemote(
        networkContract: self.networkService
    );
    
    private(set) lazy var getUserDataSourceLocalContract = UserDataSourceLocal()
    
    
}
