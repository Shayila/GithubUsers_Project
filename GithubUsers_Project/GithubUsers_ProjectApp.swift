//
//  GithubUsers_ProjectApp.swift
//  GithubUsers_Project
//
//  Created by Shayila Kamaal on 16/07/26.
//

import SwiftUI
import SwiftData

@main
struct GithubUsers_ProjectApp: App {
   // @StateObject var path = NavigationManager()
    var body: some Scene {
        WindowGroup {
            ContentView().modelContainer(for:[RepositoryEntity.self,OwnerEntity.self])
                
        }
    }
}
