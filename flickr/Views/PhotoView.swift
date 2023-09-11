//
//  PhotoView.swift
//  flickr
//
//  Created by Jasmine Patel on 08/09/2023.
//

import SwiftUI

struct PhotoView: View {
    @ObservedObject var viewModel: PhotosViewModel
    
    let photo: PhotoElement
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            // MARK: User icon and name
            HStack {
                AsyncImage(url: URL(string: viewModel.userDetails.person?.iconUrl ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .foregroundColor(Color.gray.opacity(0.1))
                }
                .frame(width: 30, height: 30)
                Text(viewModel.userDetails.person?.username.content ?? "")
                    .font(.caption)
                Spacer()
            }
            .padding(.leading, 10)
            
            // MARK: Photo
            AsyncImage(url: URL(string: photo.photoUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 100)
            }
            .padding(10)
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(viewModel: PhotosViewModel(), photo: PhotoElement())
    }
}
