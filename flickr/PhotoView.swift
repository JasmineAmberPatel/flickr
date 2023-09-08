//
//  PhotoView.swift
//  flickr
//
//  Created by Jasmine Patel on 08/09/2023.
//

import SwiftUI

struct PhotoView: View {
    @ObservedObject var viewModel: PhotosViewModel
    
    init(_ viewModel: PhotosViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            AsyncImage(url: URL(string: viewModel.photos.photo?.first?.photoUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Rectangle()
            }
            .frame(width: 300, height: 300)
            .background(Color.gray.opacity(0.3))
            
            Text(viewModel.photos.photo?.first?.title ?? "")
        }
        .task {
            do {
                try await viewModel.getPhotos()
            } catch {
                print("invalid url")
            }
        }
    }
}

//struct PhotoView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoView(photos: Photos)
//    }
//}
