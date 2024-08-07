//
//  APIService.swift
//  Tracktify
//
//  Created by Christian Catenacci on 05/08/24.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    func getAccessTokenURL() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIConstants.authHost
        components.path = "/authorize"
        
        components.queryItems = APIConstants.authParams.map({URLQueryItem(name: $0, value: $1)})
        
        
        guard let url = components.url else { return nil }
        
        print(url)
        
        return URLRequest(url: url)
    }
    
}

struct Response: Codable {
    let tracks: Track
}

struct Track: Codable {
    let items: [Item]
}

struct Item: Codable {
    let name: String
}
