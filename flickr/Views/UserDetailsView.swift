//
//  UserDetailsView.swift
//  flickr
//
//  Created by Jasmine Patel on 18/10/2023.
//

import SwiftUI

struct UserDetailsView: View {
    @ObservedObject var viewModel: PhotosViewModel
    
    var body: some View {
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
                .bold()
        }
        .padding(.leading, 10)
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleUserDetails = UserDetails(person: Person(username: Description(content: "sampleUsername")))
        let viewModel = PhotosViewModel()
        viewModel.userDetails = sampleUserDetails
        
        return UserDetailsView(viewModel: viewModel)
    }
}
