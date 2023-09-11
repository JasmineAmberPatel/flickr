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
    let imageDetails: ImageDetails
    
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
                Text(dateFormatter.string(from: dateFormatter.date(from: imageDetails.photo?.dates?.posted ?? "") ?? Date()))
            }
            ScrollView {
                if let tags = imageDetails.photo?.tags?.tag {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 8) {
                        ForEach(tags, id: \.id) { tag in
                            Text("#\(tag.raw)")
                                .padding(2)
                                .background(Color.gray.opacity(0.2))
                        }
                    }
                }
            }
            Spacer()
        }
        .padding(10)
        .task {
            do {
                try await viewModel.getImageDetails(photoId: photo.id)
            } catch {
                print("invalid url")
            }
        }
    }
}

//struct PhotoDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoDetailView(photo: PhotoElement(),
//                        userDetails: UserDetails(),
//                        viewModel: PhotosViewModel())
//    }
//}

