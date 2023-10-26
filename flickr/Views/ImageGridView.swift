//
//  ImageGridView.swift
//  flickr
//
//  Created by Jasmine Patel on 18/10/2023.
//

import SwiftUI

struct ImageGridView: View {
    let photo: PhotoElement
    
    @ObservedObject var viewModel: PhotosViewModel
    @State var gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    @State private var showAlert = false
    
    @Environment(\.dismiss) private var dismiss
    
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
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                Button {
                    NavigationUtil.popToRootView()
                } label: {
                    Image(systemName: "sparkle.magnifyingglass")
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"),
                  message: Text("Sorry, we can't get this users photos right now"),
                  dismissButton: .default(Text("Dismiss"), action: {
                dismiss()
            })
            )
        }
        .task {
            do {
                try await viewModel.getPersonsPhotos(userId: photo.owner)
            } catch {
                showAlert = true
            }
        }
    }
}

struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView(photo: PhotoElement(), viewModel: PhotosViewModel())
    }
}
