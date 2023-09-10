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
            AsyncImage(url: URL(string: photo.photoUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 100)
            }
            .padding()
        }
    }
}

//struct PhotoView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoView(PhotosViewModel())
//    }
//}
