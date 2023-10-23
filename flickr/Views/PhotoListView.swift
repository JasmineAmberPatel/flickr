//
//  PhotoListView.swift
//  flickr
//
//  Created by Jasmine Patel on 05/09/2023.
//

import SwiftUI

struct PhotoListView: View {
    @State private var searchText: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
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
                                                viewModel: viewModel)
                            } label: {
                                VStack(alignment: .leading) {
                                    PhotoView(photo: photo)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Photo Finder")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText)
                .onSubmit(of: .search, {
                    Task {
                        do {
                            try await viewModel.getPhotos(searchText: searchText)
                            if viewModel.photoSearch.photos?.photo?.isEmpty ?? true {
                                                            showAlert = true
                                                            alertMessage = "Sorry, there are no results matching this search term."
                                                        }
                        } catch {
                            showAlert = true
                            alertMessage = "An error occurred while fetching data."
                        }
                    }
                })
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Error"), message: Text(alertMessage),
                          dismissButton: .default(Text("Dismiss")))
                })
            }
        }
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
