import Foundation
import SwiftUI

class CheckoutViewModel: ObservableObject {
    private let navigator: NavigationCoordinator;
    
    @Published var checkoutPhase = "delivery" // "payment"
    @Published var isAllowToShow = false;
    @Published var showBottomSheet = false;
    
    init(
        navigator: NavigationCoordinator
    ) {
        self.navigator = navigator
    }
    
    func onBack() {
        if checkoutPhase == "delivery" {
            self.navigator.popLast();
        } else {
            self.backToDelivery()
        }
    }
    
    func nextToPayment(){
        if checkoutPhase == "delivery" {
            checkoutPhase = "payment"
        }
    }
    
    func backToDelivery() {
        if checkoutPhase == "payment" {
            checkoutPhase = "delivery"
        }
    }
    
    func processToPayment() {
        if checkoutPhase == "delivery" {
            nextToPayment()
            return
        }
        
        if checkoutPhase
            == "payment" {
            withAnimation {
                showBottomSheet = true
            }
        }
    }
}
