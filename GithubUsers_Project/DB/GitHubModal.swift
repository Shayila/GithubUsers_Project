//
//  GitHubModal.swift
//  GithubUsers_Project
//
//  Created by Shayila Kamaal on 17/07/26.
//
import SwiftUI
import SwiftData

/*
 var id : Int? = 0
 var nodeID: String? = ""
 var name: String? = ""
 var fullName: String? = ""
 var itemPrivate: Bool? = false
 var owner: Owner
 var htmlUrl : String? = ""
 var gitDescription : String? = ""
 var createdAt : String? = ""
 var updatedAt : String? = ""
 var gitUrl : String? = ""
 var language : String? = ""
 var topics : [String]? = [String]()
 var visibility : String? = ""
 var forks : Int? = 0
 var openIssues : Int? = 0
 var watchers : Int? = 0
 var defaultBranch : String? = ""
 var score : Double? = 0
*/
@Model
class RepositoryEntity {
    
    @Attribute
    var id : Int
    
    var nodeID: String
    var name: String
    var fullName: String
    var itemPrivate: Bool
    
    @Relationship(deleteRule: .cascade)
    var owner: OwnerEntity
    
    var htmlUrl : String
    var gitDescription : String
    var createdAt : String
    var updatedAt : String
    var gitUrl : String
    var language : String
    var topics : [String]
    var visibility : String
    var forks : Int
    var openIssues : Int
    var watchers : Int
    var defaultBranch : String
    var score : Double
    var forkUrl : String
    
    
    init(id: Int, nodeID: String, name: String, fullName: String, itemPrivate: Bool, owner: OwnerEntity, htmlUrl: String, gitDescription: String, createdAt: String, updatedAt: String, gitUrl: String, language: String, topics: [String], visibility: String, forks: Int, openIssues: Int, watchers: Int, defaultBranch: String, score: Double,forkUrl: String) {
        self.id = id
        self.nodeID = nodeID
        self.name = name
        self.fullName = fullName
        self.itemPrivate = itemPrivate
        self.owner = owner
        self.htmlUrl = htmlUrl
        self.gitDescription = gitDescription
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.gitUrl = gitUrl
        self.language = language
        self.topics = topics
        self.visibility = visibility
        self.forks = forks
        self.openIssues = openIssues
        self.watchers = watchers
        self.defaultBranch = defaultBranch
        self.score = score
        self.forkUrl = forkUrl
    }
}



/*
 let id : Int
 let avatar : String
 let viewType : String
 let url : String
 let loginName : String
 let type : String
 */

@Model
class OwnerEntity {
    
    @Attribute
    var id : Int
    
    var avatar : String
    var viewType : String
    var url : String
    var loginName : String
    var type : String
    
    init(id: Int, avatar: String, viewType: String, url: String, loginName: String, type: String) {
        self.id = id
        self.avatar = avatar
        self.viewType = viewType
        self.url = url
        self.loginName = loginName
        self.type = type
    }
}
