//
//  NavigationManager.swift
//  GithubUsers_Project
//
//  Created by Shayila Kamaal on 16/07/26.
//

import SwiftUI
import Combine

class NavigationManager : ObservableObject {
    var path = NavigationPath()
    
    func pushView(view : String) {
        path.append(view)
    }
    
    func popView()
    {
        path.removeLast(path.count)
    }
}
