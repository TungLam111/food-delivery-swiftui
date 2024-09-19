//
//  LandingViewModel.swift
//  dev
//
//  Created by phan dam tung lam on 9/7/24.
//

import Foundation
import SwiftUI

struct LandingBanner {
    var image: String;
    var title: String;
    var subtitle: String;
    var buttonTitle: String;
}


class LandingViewModel : ObservableObject {
    private let navigator: NavigationCoordinator;
    var landingData : [LandingBanner] = [];
    @Published var currentPage = 0;
    
    init(
        navigator: NavigationCoordinator
    ) {
     
        self.navigator = navigator
        
        landingData.append(LandingBanner(image: "landing_gourmet", title: "Are you a gourmet?", subtitle: "We have a delicious menu where you can find a huge assortment of espresso, black and instant coffee", buttonTitle: "Next"))
        landingData.append(LandingBanner(image: "landing_payment", title: "Payment Problems?", subtitle: "Payment has never been so easy, just a few taps and your coffee is on its way", buttonTitle: "Next"))
        landingData.append(LandingBanner(image: "landing_delivery", title: "Don't like waiting?", subtitle: "Track your order, contact the deliveryman and just appreciate our fast delivery service ", buttonTitle: "Finish"))
    }
    
    func navToAuthentication(){
        if self.currentPage == (self.landingData.count - 1) {
            self.navigator.push(RootViewModel.Destination.authentication(
                vm: DependencyInjector.instance.viewModelsDI.authentication(navigationCoordinator: self.navigator)))
        } else {
            withAnimation {
                self.currentPage += 1
            }
        }
    }
}
