//
//  PhotoDetailView.swift
//  flickr
//
//  Created by Jasmine Patel on 09/09/2023.
//

import SwiftUI

struct PhotoDetailView: View {
    let photo: PhotoElement
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    @ObservedObject var viewModel: PhotosViewModel    
    @Environment(\.dismiss) private var dismiss
    
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
                        Rectangle()
                            .frame(width: 350, height: 220)
                            .foregroundColor(Color.gray.opacity(0.2))
                    }
                    Spacer()
                }
                
                // MARK: Author Details
                HStack(spacing: 0) {
                    UserDetailsView(viewModel: viewModel)
                    Text(", ")
                    Text(dateFormatter.string(from: dateFormatter.date(
                        from: viewModel.imageDetails.photo?.dates?.posted ?? "") ?? Date()))
                    Spacer()
                }
                .font(.caption)
                .padding(.bottom, 10)
                
                // MARK: Photo tags
                TagView(viewModel: viewModel)
                
                Spacer()
                
                // MARK: More photos button
                HStack {
                    Spacer()
                    NavigationLink("More Photos by: \(viewModel.userDetails.person?.username.content ?? "")") {
                        ImageGridView(photo: photo, viewModel: viewModel)
                    }
                    .frame(width: 200, height: 53)
                    .background(.black)
                    .cornerRadius(10)
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 2)
                    Spacer()
                }
                .padding(20)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .padding(10)
            .task {
                do {
                    try await viewModel.getUserDetails(userId: photo.owner)
                } catch {
                    print("failing get user details request")
                }
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
        let samplePhoto = PhotoElement(owner: "Marie Roy",
                                       title: "White-crowned Sparrow")
        let viewModel = PhotosViewModel()
        viewModel.userDetails = UserDetails(person: Person(username: Description(content: "sampleUsername")))
        viewModel.imageDetails = ImageDetails(photo: Photo(tags: Tags(tag: [
            Tag(id: "1", raw: "Birds"),
            Tag(id: "2", raw: "Trees"),
            Tag(id: "3", raw: "Nature"),
            Tag(id: "4", raw: "Photography"),
            Tag(id: "5", raw: "Landscape"),
            Tag(id: "6", raw: "Natural"),
            Tag(id: "7", raw: "Green")
        ])))
        
        return PhotoDetailView(photo: samplePhoto, viewModel: viewModel)
    }
}
