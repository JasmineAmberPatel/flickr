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
                                try await viewModel.searchPhotos(searchText: searchText)
                            } catch {
                                print("invalid url")
                            }
                        }
                    }
            }
            .padding()
            
            // MARK: Image list
            NavigationView {
                List {
                    if let photos = viewModel.flickrPhotos.photos?.photo {
                        ForEach(photos, id: \.self) { photo in
                            NavigationLink {
                                PhotoDetailView(photo: photo, viewModel: viewModel)
                            } label: {
                                PhotoView(viewModel: viewModel, photo: photo)
                            }
                        }
                    }
                }
            }
        }
        .background(Color.gray.opacity(0.1))
        .task {
            do {
                try await viewModel.searchPhotos(searchText: "yorkshire")
            } catch {
                print("invalid url")
            }
        }
    }
}

//struct PhotoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoListView(viewModel: PhotosViewModel(photo: PhotoElement()))
//    }
//}
