import SwiftUI

struct LandingView: View {
    
    @StateObject var viewModel: LandingViewModel;
    
    var body: some View {
        VStack (alignment: .leading) {
            // Top part of the screen with image
            VStack (alignment: .leading) {
                Spacer()
                ScrollingImageCarousel(
                    currentPage: $viewModel.currentPage,
                    imageUrls:
                        self.viewModel.landingData.map { $0.image },
                    onChange: { index in
                        self.viewModel.currentPage = index
                    })
                .frame(
                    maxWidth: .infinity, maxHeight: .infinity, alignment: .center
                )
                
                Spacer()
            }
            .frame(
                maxWidth: .infinity
            )
            .background(ColorConstants.cFF2E2E2D)
            .padding(.top, 100)
            
            
            VStack {
                VStack(spacing: 50) {
                    Text(viewModel.landingData[viewModel.currentPage].title)
                        .customFont(size: 30, weight: .medium)
                    
                    Text(viewModel.landingData[viewModel.currentPage].subtitle)
                        .customFont(size: 20,  weight: .medium)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                    
                    Button(action: {
                        viewModel.navToAuthentication()
                    }) {
                        Text(viewModel.landingData[viewModel.currentPage].buttonTitle)
                            .customFont(size: 20)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(ColorConstants.cFF2E2E2D)
                            .cornerRadius(10)
                    }
                }
                .padding(.bottom, 16)
                .padding(.horizontal, 20)
                .background(ColorConstants.cFFFAF8F5)
            }.frame(
                maxWidth: .infinity,
                maxHeight: UIScreen.main.bounds.height * 0.35
            ).padding(.top, 30)
                .padding(.bottom, 30)
                .background(ColorConstants.cFFFAF8F5)
                .clipShape(
                    .rect(
                        topLeadingRadius: 20,
                        topTrailingRadius: 20
                    )
                )
        }
        .navigationBarBackButtonHidden()
        .edgesIgnoringSafeArea(.all)
        .background(ColorConstants.cFF2E2E2D)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .ignoresSafeArea()
    }
}


#Preview {
    LandingView(
        viewModel: LandingViewModel(
            navigator: MockNavigationCoordinator()
        )
    )
}
