//
//  CouponViewModel.swift
//  dev
//
//  Created by phan dam tung lam on 10/8/24.
//

import Foundation

class CouponViewModel : BaseViewModel {
    private let navigator: NavigationCoordinator;
    private let argument: CouponArgs;
    
    private let getListCouponUsecase : GetListCouponUsecase;

    @Published var coupons: [Coupon] = []

    
    init(navigator: NavigationCoordinator, argument: CouponArgs, getListCouponUsecase: GetListCouponUsecase) {
        self.navigator = navigator
        self.argument = argument
        self.getListCouponUsecase = getListCouponUsecase
        
        super.init()
        setup()
    }
            
    func setup() {
        getListCoupon()
    }
    
    func getListCoupon() {
        DispatchQueue.main.async {
            Task {
                self.mainLoadingStatus.toggle()
                do {
                    let result : DataState<[Coupon]?> = try await self.getListCouponUsecase.execute()
                    
                    if result.isSuccess {
                        self.coupons = (result.data ?? []) ?? []
                    }
                    self.mainLoadingStatus.toggle()
                } catch {
                    self.mainLoadingStatus.toggle()
                }
            }
        }
    }
    
    func onBack() {
        self.navigator.popLast()
    }
    
    func onSelectCoupon(coupon: Coupon) {
        self.argument.onSelect(coupon.id)
        self.onBack()
    }
}
