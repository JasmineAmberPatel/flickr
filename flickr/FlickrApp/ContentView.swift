//
//  ContentView.swift
//  flickr
//
//  Created by Jasmine Patel on 10/09/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PhotosViewModel()
    
    var body: some View {
        PhotoListView(viewModel: viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
