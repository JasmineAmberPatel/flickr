//
//  ImageGridView.swift
//  flickr
//
//  Created by Jasmine Patel on 18/10/2023.
//

import SwiftUI

struct ImageGridView: View {
    
    @ObservedObject var viewModel: PhotosViewModel
    @State var gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        ScrollView {
            if let photos = viewModel.authorPhotos.photos?.photo {
                LazyVGrid(columns: gridLayout, alignment: .center) {
                    ForEach(photos, id: \.self) { photo in
                            NavigationLink {
                                PhotoDetailView(photo: photo,
                                                viewModel: viewModel)
                            } label: {
                                AsyncImage(url: URL(string: photo.photoUrl)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: (UIScreen.main.bounds.width - 40) / 3, height: (UIScreen.main.bounds.width - 40) / 3)
                                    .cornerRadius(5)
                            } placeholder: {
                                Rectangle()
                                    .frame(width: (UIScreen.main.bounds.width - 40) / 3, height: (UIScreen.main.bounds.width - 40) / 3)
                                    .foregroundColor(Color.gray.opacity(0.2))
                            }
                        }
                    }
                }
            }
        }
        .padding(10)
        .task {
            do {
                try await viewModel.getPersonsPhotos(userId: viewModel.userDetails.person?.username.content ?? "")
            } catch {
                print("failing get author photos request")
            }
        }
    }
}

struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView(viewModel: PhotosViewModel())
    }
}
