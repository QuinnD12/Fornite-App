//
//  API Manager.swift
//  Fornite App
//
//  Created by Quinn B. Davis on 11/17/23.
//

import Foundation

func getID(_ username: String, platform: String = "epic") async throws -> String {
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
    
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(FortniteID.self, from: data).accountId
    } catch {
        throw NetworkError.invalidData
    }
    
    
}

func getUser(_ user: String) async throws -> String {
    let endpoint = "https://fortnite-api.com/v2/stats/br/v2/\(user)"
    
    guard let url = URL(string: endpoint) else {
        throw NetworkError.invalidURL
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("d9a44c71-4a69-490d-8bf1-50fe2309ff24", forHTTPHeaderField: "Authorization")
    
    do {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        if httpResponse.statusCode == 200 {
            if let decodedString = String(data: data, encoding: .utf8) {
                return decodedString
            } else {
                print("Error decoding data as UTF-8 string.")
                throw NetworkError.invalidData
            }
        } else {
            print("Unexpected status code: \(httpResponse.statusCode)")
            print("Response body: \(String(data: data, encoding: .utf8) ?? "N/A")")
            throw NetworkError.invalidResponse
        }
    } catch {
        print("Error: \(error)")
        throw NetworkError.invalidData
    }

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

struct FortniteID: Codable {
    let result: Bool
    let accountId: String
}

struct ForniteUser: Codable {
    let status: Int
    let data: DataClass
}

struct DataClass: Codable {
    let account: Account
    let battlePass: BattlePass
    let image: String
    let stats: Stats
}

struct Account: Codable {
    let id, name: String
}

struct BattlePass: Codable {
    let level, progress: Int
}

struct Stats: Codable {
    let all, keyboardMouse, gamepad, touch: All
}

struct All: Codable {
    let overall, solo: Overall?
    let duo: Overall?
    let trio: Overall?
    let squad: Overall?
    let ltm: Overall?
}

struct Overall: Codable {
    let score: Int
    let scorePerMin, scorePerMatch: Double
    let wins: Int
    let top5, top12: Int?
    let kills: Int
    let killsPerMin, killsPerMatch: Double
    let deaths: Int
    let kd: Double
    let matches: Int
    let winRate: Double
    let minutesPlayed, playersOutlived: Int
    let lastModified: Date
    let top3, top6, top10, top25: Int?
}
