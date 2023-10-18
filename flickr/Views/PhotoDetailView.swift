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
        formatter.dateStyle = .medium
        return formatter
    }
    
    @ObservedObject var viewModel: PhotosViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // MARK: Photo title
                Text(photo.title)
                    .bold()
                
                // MARK: Photo
                HStack {
                    Spacer()
                    AsyncImage(url: URL(string: photo.photoUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 100, height: 100)
                    }
                    Spacer()
                }
                
                // MARK: Author Details
                HStack(spacing: 0) {
                    UserDetailsView(viewModel: viewModel)
                    Text(", ")
                    Text(dateFormatter.string(from: dateFormatter.date(
                        from: imageDetails.photo?.dates?.posted ?? "") ?? Date()))
                    Spacer()
                }
                .font(.caption)
                .padding(.bottom, 10)
                
                // MARK: Photo tags
                TagView(imageDetails: imageDetails)
                
                Spacer()
                
                // MARK: More photos button
                HStack {
                    Spacer()
                    Button {
                        print("navigate forwards")
                    } label: {
                        Text("More Photos by \(userDetails.person?.username.content ?? "")")
                            .font(.footnote)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .frame(width: 200, height: 53)
                    .background(.black)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 2)
                    Spacer()
                }
                .padding(20)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .padding(15)
            .task {
                do {
                    try await viewModel.getImageDetails(photoId: photo.id)
                } catch {
                    print("Failing getImageDetails request")
                }
            }
        }
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailView(photo: PhotoElement(),
                        userDetails: UserDetails(),
                        imageDetails: ImageDetails(),
                        viewModel: PhotosViewModel())
    }
}
