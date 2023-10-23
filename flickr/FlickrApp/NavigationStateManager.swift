//
//  NavigationStateManager.swift
//  flickr
//
//  Created by Jasmine Patel on 23/10/2023.
//

import Foundation

enum AppNavigation: Hashable {
    case search
    case details
}

class NavigationStateManager: ObservableObject {
    @Published var selectionPath = [AppNavigation]()
    
    
    func popToRoot() {
        selectionPath = []
    }
    
    func goBack() {
        selectionPath.removeLast()
    }
}
