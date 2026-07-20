//
//  OfflineModel.swift
//  GithubUsers_Project
//
//  Created by Shayila Kamaal on 17/07/26.
//

import Foundation
import SwiftUI
import SwiftData


final class OfflineModel {
    
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }
    
    
    func saveRepositories(list : [Repository]) {
        
        for repo in list {
            let ownerEntity = OwnerEntity(id: repo.owner.id!, avatar: repo.owner.avatar ?? "", viewType: repo.owner.viewType ?? "", url: repo.owner.url ?? "", loginName: repo.owner.loginName ?? "", type: repo.owner.type ?? "")
            
            let repoEntity = RepositoryEntity(id: repo.id!, nodeID: repo.nodeID!, name: repo.name ?? "", fullName: repo.fullName ?? "", itemPrivate: repo.itemPrivate ?? false, owner: ownerEntity, htmlUrl: repo.htmlUrl ?? "", gitDescription: repo.gitDescription ?? "", createdAt: repo.createdAt ?? "", updatedAt: repo.updatedAt ?? "", gitUrl: repo.gitUrl ?? "", language: repo.language ?? "", topics: repo.topics ?? [String](), visibility: repo.visibility ?? "", forks: repo.forks ?? 0, openIssues: repo.openIssues ?? 0, watchers: repo.watchers ?? 0, defaultBranch: repo.defaultBranch ?? "", score: repo.score ?? 0,forkUrl: repo.forkUrl ?? "")
            
            context.insert(repoEntity)
            
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to save:", error)
        }
    }
    
    func deleteAllRows() {
        do {
            try context.delete(model: RepositoryEntity.self)
            try context.delete(model: OwnerEntity.self)
        }
        catch {
            print("Error happened while deleting: \(error.localizedDescription)")
        }
    }
    
    func fetchRepositories() -> [Repository]{
        var repositories = [Repository]()
        
        let descriptor = FetchDescriptor<RepositoryEntity>()
        
        do {
            let result = try context.fetch(descriptor)
            
          repositories = result.map{ repo in
              Repository(id: repo.id, nodeID: repo.nodeID, name: repo.name, fullName: repo.fullName, itemPrivate: repo.itemPrivate, owner: Owner(id: repo.owner.id, avatar: repo.owner.avatar, viewType: repo.owner.viewType, url: repo.owner.url, loginName: repo.owner.loginName, type: repo.owner.type), htmlUrl: repo.htmlUrl, gitDescription: repo.gitDescription, createdAt: repo.createdAt, updatedAt: repo.updatedAt, gitUrl: repo.gitUrl, language: repo.language, topics: repo.topics, visibility: repo.visibility, forks: repo.forks, openIssues: repo.openIssues, watchers: repo.watchers, defaultBranch: repo.defaultBranch, score: repo.score,forkUrl: repo.forkUrl)
            }
        }
        catch {
            print("Error happen :\(error.localizedDescription)")
        }
        return repositories
    }
}


