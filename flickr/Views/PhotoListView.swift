//
//  PhotoListView.swift
//  flickr
//
//  Created by Jasmine Patel on 05/09/2023.
//

import SwiftUI

struct PhotoListView: View {
    @State private var searchText: String = ""
    @FocusState private var textField: Bool
    @ObservedObject var viewModel: PhotosViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            // MARK: Image list
            NavigationView {
                List {
                    if let photos = viewModel.photoSearch.photos?.photo {
                        ForEach(photos, id: \.self) { photo in
                            NavigationLink {
                                PhotoDetailView(photo: photo,
                                                userDetails: viewModel.userDetails,
                                                imageDetails: viewModel.imageDetails,
                                                viewModel: viewModel)
                            } label: {
                                PhotoView(viewModel: viewModel, photo: photo)
                            }
                            .task {
                                do {
                                    try await viewModel.getUserDetails(userId: photo.owner)
                                } catch {
                                    print("failing get user details request")
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Image Search")
                .searchable(text: $searchText)
                .onSubmit(of: .search, {
                    Task {
                        do {
                            try await viewModel.getPhotos(searchText: searchText)
                        } catch {
                            print("invalid url")
                        }
                    }
                })
            }
        }
        .background(Color.gray.opacity(0.1))
        .task {
            do {
                try await viewModel.getPhotos(searchText: "trees")
            } catch {
                print("Failing getPhotos request")
            }
        }
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView(viewModel: PhotosViewModel())
    }
}
