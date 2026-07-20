//
//  Constant.swift
//  GithubUsers_Project
//
//  Created by Shayila Kamaal on 16/07/26.
//

import Foundation
//https://api.github.com/search/repositories?q=swift&sort=stars&page=1&per_page=4
//https://api.github.com/search/repositories?q=swift&sort=stars&order=desc&page=1&per_page=20
//https://api.github.com/search/repositories?q=stars:>0&sort=stars&order=desc&page=1&per_page=2
let baseURL : String = "https://api.github.com"

struct Path {
    var listGitHub : String {return "\(baseURL)/search/repositories?q=stars:>0"}
    var searchGitHub : String {return "\(baseURL)/search/repositories?"}
}


extension URL {
    mutating func appendQueryItem(name : String, value : String?) {
        
        guard var urlComponents = URLComponents(string: absoluteString) else { return }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Create query item
        let queryItem = URLQueryItem(name: name, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        self = urlComponents.url!
    }
}

struct Constant {
    
    
    static func removeDuplicates(from list : [Repository]) -> [Repository] {
        var response = Set<Repository>()
        return list.filter{response.insert($0).inserted}
    }
    
    static func removeDuplicates(from list : [Repository],and secondList : [Repository]) -> [Repository] {
        /*let ids = Set(oldList.compactMap(\.id))
         self?.repoList += gitHub.items.filter{!ids.contains($0.id ?? 0)}*/
        let insertedIds = Set(list.compactMap(\.id))
        var response = Set<Repository>()
        return secondList.filter{!insertedIds.contains($0.id ?? 0) && response.insert($0).inserted}
    }
    
    static func formatCount(_ value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 0

        if value >= 1_000_000 {
            let number = NSNumber(value: Double(value) / 1_000_000)
            return "\(formatter.string(from: number) ?? "")M"
        } else if value >= 1_000 {
            let number = NSNumber(value: Double(value) / 1_000)
            return "\(formatter.string(from: number) ?? "")K"
        } else {
            return "\(value)"
        }
    }
}
