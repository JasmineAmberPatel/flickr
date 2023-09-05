//
//  PhotoListView.swift
//  flickr
//
//  Created by Jasmine Patel on 05/09/2023.
//

import SwiftUI

struct PhotoListView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
        // MARK: Search bar
            HStack {
                TextField("Search", text: $searchText)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    .textFieldStyle(.roundedBorder)
                Image(systemName: "magnifyingglass")
            }
            .padding()
            
            Spacer()
        }
        .background(Color.gray.opacity(0.3))
        
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView()
    }
}
