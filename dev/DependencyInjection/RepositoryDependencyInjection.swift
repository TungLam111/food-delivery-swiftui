//
//  RepositoryDependencyInjection.swift
//  dev
//
//  Created by phan dam tung lam on 14/7/24.
//

import Foundation

class RepositoriesDependencyInjection {
    
    var datasourcesDI: DatasoucesDependencyInjection;
    
    init(datasourcesDI: DatasoucesDependencyInjection) {
        self.datasourcesDI = datasourcesDI
    }
    
    private(set) lazy var foodRepository = FoodRepositoryImpl(
            remoteDataSource: self.datasourcesDI.getFoodDataSourceRemoteContract ,
            localDataSource: self.datasourcesDI.getFoodDataSourceLocalContract
        )
}
