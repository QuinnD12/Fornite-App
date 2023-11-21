//
//  API Manager.swift
//  Fornite App
//
//  Created by Quinn B. Davis on 11/17/23.
//

import Foundation

func getUser(_ username: String, platform: String = "epic") async throws -> String {
    let endpoint = "https://fortniteapi.io/v2/lookup?username=\(username)&platform=\(platform)"
    guard let url = URL(string: endpoint) else {
        throw NetworkError.invalidURL
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("51ecb01b-82cf0a62-640d2dd4-37caa501", forHTTPHeaderField: "Authorization")
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw NetworkError.invalidResponse
    }
    
    
    /*do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(GitHubUser.self, from: data)
    } catch {
        throw NetworkError.invalidData
    }*/
    
    return String(decoding: data, as: UTF8.self)
}

//struct ForniteUser: Codable {
//
//}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
