//
//  UserVM_Repo.swift
//  GithubUsers_Project
//
//  Created by Shayila Kamaal on 16/07/26.
//


import Foundation
import Combine
import SwiftUI

//Direct: https://api.github.com/search/repositories?q=swift&sort=stars&page=1&per_page=4
struct UserRequestManager : APIDelegate {
    
    func compoundURL(from request: [String: Any]) -> URL {
        var url = URL(string: Path().listGitHub)
        if let _ = request["q"] as? String {
         url = URL(string: "\(Path().searchGitHub)")!
     }
        
        for (key,value) in request {
            
            
            url?.appendQueryItem(name: key, value: value as? String)
        }
        
        print(url?.absoluteString ?? "")
        
        return url!
    }
    
    
    func getParsedResponse(from data: Data) -> AnyPublisher<GitHubList, APIError> {
        do {
            let response = try JSONDecoder().decode(GitHubList.self, from: data)
            
            return Just(response)
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
            
        }
        catch {
           return Fail(error: APIError.decodingError(error)).eraseToAnyPublisher()
        }
    }
    
}
