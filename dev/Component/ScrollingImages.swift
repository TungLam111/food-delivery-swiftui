import SwiftUI

struct ScrollingImageCarousel: View {
    let imageUrls: [String]
    
    @State private var currentPage = 0
    let carouselHeight: CGFloat = 240 // Set your desired height here

    var body: some View {
        VStack {
            GeometryReader { geometry in
                    HStack(spacing: 0) {
                        ForEach(imageUrls.indices, id: \.self) { index in
                            let imageUrl = imageUrls[index]
                            AsyncImage(url: URL(string: imageUrl)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: geometry.size.width, height: carouselHeight)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width, height: carouselHeight)
                                        .clipShape(Circle())
                                case .failure:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width, height: carouselHeight)
                                        .clipShape(Circle())
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .shadow(radius: 10)
                        }
                    }
                    .frame(width: geometry.size.width, height: carouselHeight, alignment: .leading)
                    .offset(x: CGFloat(currentPage) * -geometry.size.width)
                    .animation(.default, value: true)
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                let offset = value.translation.width
                                if (offset > 10) {
                                    if (self.currentPage >= 1) {
                                        self.currentPage -= 1
                                    }
                                } else if (offset < -10) {
                                    if (self.currentPage < imageUrls.count - 1 ) {
                                        self.currentPage += 1
                                    }
                                }
                                
                                print(self.currentPage)
                            }
                    )
                .frame(width: geometry.size.width, height: carouselHeight)
                .contentShape(Rectangle())
                .onTapGesture {
                    // Handle tap gesture if needed
                }
            }.frame(height: carouselHeight)
            
            Spacer().frame(height: 15)
            
            HStack(alignment: .center, spacing: 10) {
                ForEach(imageUrls.indices, id: \.self) { index in
                    if (index == currentPage) {
                        return Circle()
                            .fill(ColorConstants.cFFFA4A0C)
                            .frame(width: 10, height: 10)
                    } else {
                        return Circle()
                            .fill(ColorConstants.cFFC4C4C4)
                            .frame(width: 10, height: 10)
                       }
                    }
                }
            }
    }
}
