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
            
            // MARK: Title
            Text("Image Search")
                .font(.title)
                .bold()
            
            // MARK: Search bar
            HStack(spacing: 0) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 25))
                    .padding(.trailing, 10)
                TextField("Search", text: $searchText)
                    .focused($textField)
                    .textFieldStyle(.roundedBorder)
                    .submitLabel(.done)
                    .keyboardType(.namePhonePad)
                    .onSubmit {
                        Task {
                            do {
                                try await viewModel.getPhotos(searchText: searchText)
                            } catch {
                                print("invalid url")
                            }
                        }
                    }
            }
            .padding(10)
            
            // MARK: Image list
            NavigationView {
                List {
                    if let photos = viewModel.flickrPhotos.photos?.photo {
                        ForEach(photos, id: \.self) { photo in
                            NavigationLink {
                                PhotoDetailView(photo: photo,
                                                userDetails: viewModel.userDetails,
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
            }
        }
        .background(Color.gray.opacity(0.1))
        .task {
            do {
                try await viewModel.getPhotos(searchText: "yorkshire")
            } catch {
                print("failing get photos request")
            }
        }
    }
}

//struct PhotoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoListView(viewModel: PhotosViewModel(photo: PhotoElement()))
//    }
//}
