//
//  PhotoListView.swift
//  flickr
//
//  Created by Jasmine Patel on 05/09/2023.
//

import SwiftUI

struct PhotoListView: View {
    @State private var searchText: String = ""
    @ObservedObject private var viewModel = PhotosViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
        // MARK: Search bar
            HStack {
                TextField("Search", text: $searchText)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            
            PhotoView(viewModel)
            
            Spacer()
        }
        .background(Color.gray.opacity(0.3))
    }
}

//struct PhotoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoListView()
//    }
//}
