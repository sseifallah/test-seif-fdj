//
//  APIService.swift
//  Test Seif
//
//  Created by  Seif on 19/05/2022.
//

import Foundation

class APIService {
    static var shared: APIService {
        return APIService()
    }
    
    func getLeagueTeams(league: String) async -> [Team]? {
        
        var serviceURL = URLComponents(string: APIEndpoints.getTeamsURL)!
        serviceURL.queryItems = [URLQueryItem(name: "l", value: league)]
        let (data, response, _) = await URLSession.shared.dataTask(with: serviceURL.url!)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {return nil}
        guard let data = data else { return nil }
        let teams = try? JSONDecoder().decode(LeagueTeams.self, from: data)
        return teams?.teams
    }
    
    func getLeagues() async -> [League]? {
        
        let serviceURL = URL(string: APIEndpoints.getLeaguesURL)!
        let (data, response, _) = await URLSession.shared.dataTask(with: serviceURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {return nil}
        guard let data = data else { return nil }
        let leaguesResponse = try? JSONDecoder().decode(Leagues.self, from: data)
        var soccerLeagues = [League]()
        guard let leagues = leaguesResponse?.leagues else {return nil}
        for league in leagues where league.sport == "Soccer"{
            soccerLeagues.append(league)
        }
        return soccerLeagues
    }
    
}

extension URLSession {
    
    func dataTask(with url: URL) async -> (Data?, URLResponse?, Error?) {
        return await withUnsafeContinuation { continuation in
            self.dataTask(with: url) { data, response, error in
                continuation.resume(returning: (data, response, error))
            }.resume()
        }
    }
}
