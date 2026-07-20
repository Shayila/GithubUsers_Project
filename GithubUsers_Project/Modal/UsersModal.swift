//
//  UsersModal.swift
//  GithubUsers_Project
//
//  Created by Shayila Kamaal on 16/07/26.
//

import Foundation



//MARK: - GitHub Modal
struct GitHubList : Codable {
    let total : Int
    let incompleteResult : Bool
    let items : [Repository]
    
    enum CodingKeys : String, CodingKey {
        case total = "total_count"
        case incompleteResult = "incomplete_results"
        case items = "items"
    }
}

//MARK: - Repo Modal
struct Repository : Codable, Identifiable, Hashable {
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
    var forkUrl : String? = ""
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case nodeID = "node_id"
        case name = "name"
        case fullName = "full_name"
        case itemPrivate = "private"
        case owner = "owner"
        case htmlUrl = "html_url"
        case gitDescription = "description"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case gitUrl = "git_url"
        case language = "language"
        case topics = "topics"
        case visibility = "visibility"
        case forks = "forks"
        case openIssues = "open_issues"
        case watchers = "watchers"
        case defaultBranch = "default_branch"
        case score = "score"
        case forkUrl = "forks_url"
    }
}



//MARK: - Owner Info Modal
struct Owner : Codable, Identifiable, Hashable {
    var id : Int? = 0
    var avatar : String? = ""
    var viewType : String? = ""
    var url : String? = ""
    var loginName : String? = ""
    var type : String? = ""
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case loginName = "login"
        case avatar = "avatar_url"
        case viewType = "user_view_type"
        case url = "url"
        case type = "type"
    }
}













