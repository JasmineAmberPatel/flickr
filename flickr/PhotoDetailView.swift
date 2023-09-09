//
//  PhotoDetailView.swift
//  flickr
//
//  Created by Jasmine Patel on 09/09/2023.
//

import SwiftUI

struct PhotoDetailView: View {
    let photo: PhotoElement
    @ObservedObject var viewModel: PhotosViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(photo.title)
            PhotoView(viewModel: viewModel, photo: photo)
            Spacer()
        }
        .padding()
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailView(photo: PhotoElement(), viewModel: PhotosViewModel())
    }
}

