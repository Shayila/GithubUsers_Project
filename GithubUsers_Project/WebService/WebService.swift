//
//  WebService.swift
//  GithubUsers_Project
//
//  Created by Shayila Kamaal on 16/07/26.
//
/*https://api.github.com/search/repositories?q=swift&sort=stars&page=10&per_page=40*/

import Foundation
import Combine

enum APIError : Error{
    case invalidURLError
    case networkError(URLError)
    case imperateError(Error)
    case decodingError(Error)
}

protocol APIDelegate {
    associatedtype requestType
    
    associatedtype responseType
    
    func compoundURL(from request : requestType) -> URL
    func getParsedResponse(from data : Data) -> AnyPublisher<responseType,APIError>
}


final class WebServiceManager <T : APIDelegate> {
    let session : URLSession
    private let delegate : T
    
    init(session: URLSession = URLSession.shared, delegate: T) {
        self.session = session
        self.delegate = delegate
    }
    
    func serviceCall(requestType : T.requestType) throws -> AnyPublisher<T.responseType, APIError> {
        
        let url = delegate.compoundURL(from: requestType)
       return self.session.dataTaskPublisher(for: url)
            .tryMap({ (data,response) in
                guard let response = response as? HTTPURLResponse else {
                        throw APIError.invalidURLError
                    }
                    print("Status:", response.statusCode)
                
                return data
            })
            .receive(on: RunLoop.main)
            .mapError({ error in
                                
                   if let urlError = error as? URLError {
                       return .networkError(urlError)
                   }

                   if error is DecodingError {
                       return .decodingError(error)
                   }
                   return .imperateError(error)
                
            })
            .flatMap({ item in
                self.delegate.getParsedResponse(from: item)
            })
            .eraseToAnyPublisher()
    }
    
    
}



