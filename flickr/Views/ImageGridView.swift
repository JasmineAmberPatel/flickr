//
//  ImageGridView.swift
//  flickr
//
//  Created by Jasmine Patel on 18/10/2023.
//

import SwiftUI

struct ImageGridView: View {
    var authorPhotos: AuthorPhotos
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 0))], spacing: 10) {
                if let photos = authorPhotos.authorPhotosList?.photo {
                    ForEach(photos, id: \.self) { photo in
                        PhotoView(photo: photo)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView(authorPhotos: AuthorPhotos())
    }
}
