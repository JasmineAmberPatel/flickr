//
//  PhotoDetailView.swift
//  flickr
//
//  Created by Jasmine Patel on 09/09/2023.
//

import SwiftUI

struct PhotoDetailView: View {
    let photo: PhotoElement
    let userDetails: UserDetails
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    @ObservedObject var viewModel: PhotosViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(photo.title)
                .bold()
            AsyncImage(url: URL(string: photo.photoUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 100)
            }
            HStack(spacing: 0) {
                Text("Photo taken by: ")
                    .bold()
                Text(userDetails.person?.username.content ?? "")
            }
            HStack(spacing: 0) {
                Text("Date: ")
                    .bold()
                Text(dateFormatter.string(from: dateFormatter.date(from: userDetails.person?.photos.firstdatetaken.content ?? "") ?? Date()))
            }
            Spacer()
        }
        .padding(10)
        
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailView(photo: PhotoElement(),
                        userDetails: UserDetails(),
                        viewModel: PhotosViewModel())
    }
}

