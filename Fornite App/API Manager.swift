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

func getUser(_ userID: String) async throws -> FortniteUser? {
    let endpoint = "https://fortnite-api.com/v2/stats/br/v2/\(userID)"
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
        
        return try decoder.decode(FortniteUser.self, from: data)
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


struct FortniteUser: Codable {
    let status: Int32?
    let data: DataClass?
}

struct DataClass: Codable {
    let account: Account?
    let battlePass: BattlePass?
    let image: String?
    let stats: Stats?
}

struct Account: Codable {
    let id, name: String?
}

struct BattlePass: Codable {
    let level, progress: Int32?
}

struct Stats: Codable {
    let all, keyboardMouse, gamepad, touch: All?
}

struct All: Codable {
    let overall: Overall?
    let solo: Solo?
    let duo: Duo?
    let trio: TrioSquad?
    let squad: TrioSquad?
    let ltm: LTM?
}

struct Overall: Codable {
    let score: Int64?
    let scorePerMin, scorePerMatch: Double?
    let wins: Int64?
    let top3, top5, top6, top10, top12, top25: Int64?
    let kills: Int64?
    let killsPerMin, killsPerMatch: Double?
    let deaths: Int64?
    let kd: Double?
    let matches: Int64?
    let winRate: Double?
    let minutesPlayed, playersOutlived: Int64?
    let lastModified: String?
}

struct Solo: Codable {
    let score: Int64?
    let scorePerMin, scorePerMatch: Double?
    let wins: Int64?
    let top10, top25: Int64?
    let kills: Int64?
    let killsPerMin, killsPerMatch: Double?
    let deaths: Int64?
    let kd: Double?
    let matches: Int64?
    let winRate: Double?
    let minutesPlayed, playersOutlived: Int64?
    let lastModified: String?
}

struct Duo: Codable {
    let score: Int64?
    let scorePerMin, scorePerMatch: Double?
    let wins: Int64?
    let top5, top12: Int64?
    let kills: Int64?
    let killsPerMin, killsPerMatch: Double?
    let deaths: Int64?
    let kd: Double?
    let matches: Int64?
    let winRate: Double?
    let minutesPlayed, playersOutlived: Int64?
    let lastModified: String?
}

struct TrioSquad: Codable {
    let score: Int64?
    let scorePerMin, scorePerMatch: Double?
    let wins: Int64?
    let top3, top6: Int64?
    let kills: Int64?
    let killsPerMin, killsPerMatch: Double?
    let deaths: Int64?
    let kd: Double?
    let matches: Int64?
    let winRate: Double?
    let minutesPlayed, playersOutlived: Int64?
    let lastModified: String?
}

struct LTM: Codable {
    let score: Int64?
    let scorePerMin, scorePerMatch: Double?
    let wins: Int64?
    let kills: Int64?
    let killsPerMin, killsPerMatch: Double?
    let deaths: Int64?
    let kd: Double?
    let matches: Int64?
    let winRate: Double?
    let minutesPlayed, playersOutlived: Int64?
    let lastModified: String?
}
