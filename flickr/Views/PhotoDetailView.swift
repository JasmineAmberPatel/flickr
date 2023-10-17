//
//  PhotoDetailView.swift
//  flickr
//
//  Created by Jasmine Patel on 09/09/2023.
//

import SwiftUI

struct PhotoDetailView: View {
    let photo: PhotoElement
    let userDetails: UserDetails
    let imageDetails: ImageDetails
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    @ObservedObject var viewModel: PhotosViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // MARK: Photo title
                Text(photo.title)
                    .bold()
                
                // MARK: Photo
                HStack {
                    Spacer()
                    AsyncImage(url: URL(string: photo.photoUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 100, height: 100)
                    }
                    Spacer()
                }
                
                // MARK: Photo details
                HStack(spacing: 0) {
                    Text("Photo taken by: ")
                        .bold()
                    Text(userDetails.person?.username.content ?? "No username available")
                }
                HStack(spacing: 0) {
                    Text("Date: ")
                        .bold()
                    Text(dateFormatter.string(from: dateFormatter.date(
                        from: imageDetails.photo?.dates?.posted ?? "") ?? Date()))
                }
                
                // MARK: Tags
                FlowLayout {
                    if let tags = imageDetails.photo?.tags?.tag {
                        ForEach(tags, id: \.id) { tag in
                            HStack {
                                Text("#\(tag.raw)")
                                    .font(.caption)
                                    .fixedSize()
                            }
                            .padding(6)
                            .background(
                                Capsule()
                                    .stroke(Color.black)
                                    .background(Capsule().fill(Color.gray.opacity(0.1)))
                            )
                            .padding(4)
                        }
                    }
                }
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .padding(15)
            .task {
                do {
                    try await viewModel.getImageDetails(photoId: photo.id)
                } catch {
                    print("Failing getImageDetails request")
                }
            }
        }
    }
}

struct FlowLayout: Layout {
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        
        var totalHeight: CGFloat = 0
        var totalWidth: CGFloat = 0
        
        var lineWidth: CGFloat = 0
        var lineHeight: CGFloat = 0
        
        for size in sizes {
            if lineWidth + size.width > proposal.width ?? 0 {
                totalHeight += lineHeight
                lineWidth = size.width
                lineHeight = size.height
            } else {
                lineWidth += size.width
                lineHeight = max(lineHeight, size.height)
            }
            
            totalWidth = max(totalWidth, lineWidth)
        }
        
        totalHeight += lineHeight
        
        return .init(width: totalWidth, height: totalHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        
        var lineX = bounds.minX
        var lineY = bounds.minY
        var lineHeight: CGFloat = 0
        
        for index in subviews.indices {
            if lineX + sizes[index].width > (proposal.width ?? 0) {
                lineY += lineHeight
                lineHeight = 0
                lineX = bounds.minX
            }
            
            subviews[index].place(
                at: .init(
                    x: lineX + sizes[index].width / 2,
                    y: lineY + sizes[index].height / 2
                ),
                anchor: .center,
                proposal: ProposedViewSize(sizes[index])
            )
            
            lineHeight = max(lineHeight, sizes[index].height)
            lineX += sizes[index].width
        }
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailView(photo: PhotoElement(),
                        userDetails: UserDetails(),
                        imageDetails: ImageDetails(),
                        viewModel: PhotosViewModel())
    }
}
