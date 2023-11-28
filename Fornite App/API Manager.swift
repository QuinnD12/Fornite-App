//
//  API Manager.swift
//  Fornite App
//
//  Created by Quinn B. Davis on 11/17/23.
//

import Foundation

func getUser(_ accountID: String, platform: String = "epic") async throws -> FortniteID {
    let endpoint = "https://fortnite-api.com/v2/stats/br/v2/\(accountID)"
    guard let url = URL(string: endpoint) else {
        throw NetworkError.invalidURL
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("d9a44c71-4a69-490d-8bf1-50fe2309ff24", forHTTPHeaderField: "Authorization")
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw NetworkError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(FortniteID.self, from: data)
    } catch {
        throw NetworkError.invalidData
    }
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

// MARK: - DataClass
struct DataClass: Codable {
    let account: Account
    let battlePass: BattlePass
    let image: String
    let stats: Stats
}

// MARK: - Account
struct Account: Codable {
    let id, name: String
}

// MARK: - BattlePass
struct BattlePass: Codable {
    let level, progress: Int
}

// MARK: - Stats
struct Stats: Codable {
    let all, keyboardMouse, gamepad, touch: All
}

// MARK: - All
struct All: Codable {
    let overall, solo: Overall?
    let duo: Overall?
    let trio: Overall?
    let squad: Overall?
    let ltm: Overall?
}

// MARK: - Overall
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
