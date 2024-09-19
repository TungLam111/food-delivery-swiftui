
import Foundation


class CheckCouponUsecase {
    private var paymentRepository : PaymentRepository;
    
    init(paymentRepository: PaymentRepository) {
        self.paymentRepository = paymentRepository
    }
    
    func execute(couponId: String, req: CheckCouponDto) async throws -> DataState<VerifyOrderResponseModel?> {
        return try await  self.paymentRepository.checkCoupon(couponId: couponId, req: req)
    }
}
