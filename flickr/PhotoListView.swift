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
    @ObservedObject private var viewModel = PhotosViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("Image Search")
                .font(.title)
                .bold()
            // MARK: Search bar
            HStack {
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
            .padding()
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
                .listStyle(PlainListStyle())
            }
        }
        .task {
            do { 
                try await viewModel.getPhotos(searchText: "yorkshire")
            } catch {
                print("invalid url")
            }
        }
        .padding()
        .background(Color.gray.opacity(0.3))
    }
}

//struct PhotoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoListView(viewModel: PhotosViewModel(photo: PhotoElement()))
//    }
//}
