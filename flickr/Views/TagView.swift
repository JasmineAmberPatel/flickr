//
//  TagView.swift
//  flickr
//
//  Created by Jasmine Patel on 18/10/2023.
//

import SwiftUI

struct TagView: View {
    @ObservedObject var viewModel: PhotosViewModel
    
    var body: some View {
        VStack {
            FlowLayout {
                if let tags = viewModel.imageDetails.photo?.tags?.tag {
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

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = PhotosViewModel()
        viewModel.imageDetails = ImageDetails(photo: Photo(tags: Tags(tag: [
            Tag(id: "1", raw: "Birds"),
            Tag(id: "2", raw: "Trees"),
            Tag(id: "3", raw: "Nature"),
            Tag(id: "4", raw: "Photography"),
            Tag(id: "5", raw: "Landscape"),
            Tag(id: "6", raw: "Natural"),
            Tag(id: "7", raw: "Green")
        ])))

        return TagView(viewModel: viewModel)
    }
}
