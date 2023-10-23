//
//  PhotoView.swift
//  flickr
//
//  Created by Jasmine Patel on 08/09/2023.
//

import SwiftUI

struct PhotoView: View {
    let photo: PhotoElement
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            AsyncImage(url: URL(string: photo.photoUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Rectangle()
                    .frame(width: 350, height: 220)
                    .foregroundColor(Color.gray.opacity(0.2))
            }
            Text(photo.title)
                .background(Color.black.opacity(0.3))
                .font(.caption)
                .offset(y: -15)
                .foregroundColor(.white)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
        }
        .padding(10)
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(photo: PhotoElement(title: "Bird in trees"))
    }
}
